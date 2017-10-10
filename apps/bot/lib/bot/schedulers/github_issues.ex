defmodule Bot.Scheduler.GitHubIssues do
  @moduledoc """
  GitHub Issues scheduler checks for new and closed issues on tracked repos
  """

  use GenServer

  alias Bot.GitHub
  alias Data.{Opportunities, Projects, TaskSupervisor}

  # milliseconds
  @five_minutes 300_000
  @projects_per_check 5
  # seconds
  @two_hours 7200
  # milliseconds
  @thirty_seconds 30000
  # milliseconds
  @twelve_hours @two_hours * 6000

  def check_repo(%{id: project_id, url: url}) do
    url
    |> repo
    |> GitHub.issues()
    |> Enum.map(&Map.put(&1, "project_id", project_id))
    |> Enum.each(&insert_or_update/1)
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

  def handle_info(:project_database_sync, state) do
    new_state = Map.merge(state, init_state())

    Process.send_after(self(), :project_database_sync, @twelve_hours)

    {:noreply, new_state}
  end

  def init(_opts) do
    Process.send_after(self(), :checks, @thirty_seconds)
    Process.send_after(self(), :project_database_sync, @twelve_hours)

    {:ok, init_state()}
  end

  def start_link(opts \\ []), do: GenServer.start_link(__MODULE__, %{}, opts)

  defp expired?({_id, %{last_check: last_check}}), do: last_check + @two_hours < now()

  defp init_state do
    Projects.all()
    |> Enum.map(&project_state/1)
    |> Enum.into(%{})
  end

  defp insert_or_update(%{"html_url" => html_url} = issue) do
    issue
    |> Map.put("url", html_url)
    |> Opportunities.insert_or_update()
  end

  defp now, do: DateTime.to_unix(DateTime.utc_now())

  defp perform_checks(projects), do: Enum.map(projects, &supervised_check(&1))

  defp project_state(%{id: id} = project), do: {id, Map.put(project, :last_check, random_time())}

  defp random_time, do: now() + Enum.random(1..3600)

  defp repo("https://github.com/" <> slug), do: slug

  defp supervised_check({_id, project}) do
    Task.Supervisor.start_child(TaskSupervisor, __MODULE__, :check_repo, [project])

    project
  end

  defp update_check_times(recently_checked, state) do
    recently_checked
    |> Enum.map(&Map.put(&1, :last_check, now()))
    |> Enum.reduce(state, fn %{id: id} = project, acc -> Map.put(acc, id, project) end)
  end
end
