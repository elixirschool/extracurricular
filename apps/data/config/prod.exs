use Mix.Config

pool_size =
  System.get_env()
  |> Map.get("POOL_SIZE", "10")
  |> String.to_integer

config :data, Data.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: pool_size,
  ssl: true
