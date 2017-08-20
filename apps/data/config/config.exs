use Mix.Config

config :data,
  ecto_repos: [Data.Repo],
  levels: ["beginner", "starter", "intermediate", "advanced"]

import_config "#{Mix.env}.exs"
