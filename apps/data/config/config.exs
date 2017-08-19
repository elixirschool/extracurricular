use Mix.Config

config :data, ecto_repos: [Data.Repo]

import_config "#{Mix.env}.exs"
