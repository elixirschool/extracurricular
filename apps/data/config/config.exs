use Mix.Config

config :data,
  ecto_repos: [Data.Repo],
  levels: [1, 5, 9]

config :data, Data.Repo,
  loggers: [Appsignal.Ecto, Ecto.LogEntry]

import_config "#{Mix.env}.exs"
