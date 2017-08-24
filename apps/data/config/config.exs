use Mix.Config

config :data,
  ecto_repos: [Data.Repo],
  levels: ["beginner", "intermediate", "advanced"]

config :data, Data.Repo,
  loggers: [Appsignal.Ecto, Ecto.LogEntry]

import_config "#{Mix.env}.exs"
