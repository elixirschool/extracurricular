use Mix.Config

config :data,
  ecto_repos: [Data.Repo],
  levels: [1, 5, 9],
  level_label_mapping: %{
    1 => ["kind:beginner", "kind:starter", "level:starter"],
    5 => ["kind:intermediate", "level:intermediate"],
    9 => ["kind:advanced", "level:advanced"]
  }

config :data, Data.Repo,
  loggers: [Appsignal.Ecto, Ecto.LogEntry]

import_config "#{Mix.env}.exs"
