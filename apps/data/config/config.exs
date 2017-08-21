use Mix.Config

config :data,
  ecto_repos: [Data.Repo],
  levels: ["beginner", "intermediate", "advanced"]

import_config "#{Mix.env}.exs"
