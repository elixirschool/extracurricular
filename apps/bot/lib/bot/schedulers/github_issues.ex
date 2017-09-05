defmodule Bot.Scheduler.GitHubIssues do
  @moduledoc """
  GitHub Issues scheduler checks for new and closed issues on tracked repos
  """

  use GenServer

  alias Bot.GitHub
  alias Data.{Opportunities, Projects, TaskSupervisor}

  @five_minutes 300_000 # milliseconds
  @projects_per_check 5
  @two_hours 7_200 # seconds
  @thirty_seconds 30_000 # milliseconds

  def check_repo(%{id: project_id, url: url}) do
     url
     |> repo
     |> GitHub.issues
     |> Enum.map(&Map.put(&1, "project_id", project_id))
     |> Enum.each(&Opportunities.insert_or_update/1)
  end

  def handle_info(:checks, state) do
    new_state =
      state
      |> Enum.filter(&expired?/1)
      |> Enum.take(@projects_per_check)
      |> perform_checks
      |> update_check_times(state)

    Process.send_after(self(), :checks, @five_minutes)

    {:noreply, new_state}
  end

  def init(_opts) do
    Process.send_after(self(), :checks, @thirty_seconds)

    {:ok, init_state()}
  end

  def start_link(opts \\ []), do: GenServer.start_link(__MODULE__, %{}, opts)

  defp expired?({_id, %{last_check: last_check}}), do: last_check + @two_hours < now()

  defp init_state do
    Projects.all()
    |> Enum.map(&project_state/1)
    |> Enum.into(%{})
  end

  defp now, do: DateTime.to_unix(DateTime.utc_now())

  defp perform_checks(projects), do: Enum.map(projects, &supervised_check(&1))

  defp project_state(%{id: id} = project), do: {id, Map.put(project, :last_check, random_time())}

  defp random_time, do: now() + Enum.random(1..3_600)

  defp repo("https://github.com/" <> slug), do: slug

  defp supervised_check({_id, project}) do
    Task.Supervisor.start_child(TaskSupervisor, __MODULE__, :check_repo, [project])

    project
  end

  defp update_check_times(recently_checked, state) do
    recently_checked
    |> Enum.map(&Map.put(&1, :last_check, now()))
    |> Enum.reduce(state, fn (%{id: id} = project, acc) -> Map.put(acc, id, project) end)
  end
end
