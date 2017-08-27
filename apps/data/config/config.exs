use Mix.Config

config :data,
  ecto_repos: [Data.Repo],
  level_label_mapping: %{
    1 => ["kind:beginner", "kind:starter", "level:starter"],
    5 => ["kind:intermediate", "level:intermediate"],
    9 => ["kind:advanced", "level:advanced"]
  },
  type_label_mapping: %{
    "bug" => ["kind:bug", "bug"],
    "documentation" => ["kind:documentation", "documentation"],
    "enhancement" => ["kind:enhancement", "enhancement"],
    "feature" => ["kind:feature", "feature"]
  }

config :data, Data.Repo,
  loggers: [Appsignal.Ecto, Ecto.LogEntry]

import_config "#{Mix.env}.exs"
