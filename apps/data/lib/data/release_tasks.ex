defmodule Data.ReleaseTasks do
  @moduledoc """
  A collection of tasks to be used during releases to manage the database
  """

  @start_apps [
    :crypto,
    :ecto,
    :postgrex,
    :ssl
  ]

  def migrate do
    app = application()

    IO.puts "Loading #{app}.."
    # Load the code for data, but don't start it
    :ok = Application.load(app)

    IO.puts "Starting dependencies.."
    # Start apps necessary for executing migrations
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    # Start the Repo(s) for myapp
    IO.puts "Starting repos.."
    Enum.each(repos(), fn (repo) ->
      repo.start_link(pool_size: 1)
      run_migrations_for(repo)
    end)

    # Signal shutdown
    IO.puts "Success!"
    :init.stop()
  end

  defp application do
    #{:ok, app} = Application.get_application(__MODULE__)
    #app
    :data
  end

  defp migrations_path(app), do: Path.join([priv_dir(app), "repo", "migrations"])

  defp priv_dir(app), do: "#{:code.priv_dir(app)}"

  defp repos, do: Application.get_env(application(), :ecto_repos, [])

  defp run_migrations_for(repo) do
    app = Keyword.get(repo.config, :otp_app)
    IO.puts "Running migrations for #{app}"
    Ecto.Migrator.run(repo, migrations_path(app), :up, all: true)
  end
end
