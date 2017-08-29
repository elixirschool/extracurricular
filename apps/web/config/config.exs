# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :web,
  namespace: Web,
  level_label_mapping: %{
    1 => ["Kind:Beginner", "Kind:Starter", "level:starter"],
    5 => ["Kind:Intermediate", "level:intermediate"],
    9 => ["Kind:Advanced", "level:advanced"]
  }

# Configures the endpoint
config :web, Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9UQ4sW9lcPjHiTA5tMwprAHt9nuT9AAYkXjdsWBC2AVFwKZIi/CrBGCSoqU4Aien",
  render_errors: [view: Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Web.PubSub,
           adapter: Phoenix.PubSub.PG2],
  instrumenters: [Appsignal.Phoenix.Instrumenter]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :web, :generators,
  context_app: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
