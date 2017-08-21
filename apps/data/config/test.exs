use Mix.Config

# Configure your database
config :data, Data.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "extracurricular_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
