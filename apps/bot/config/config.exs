# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :bot,
  github_url: "https://api.github.com"

import_config "#{Mix.env}.exs"
