use Mix.Config

# Configure your database
config :data, Data.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "extracurricular_dev",
  hostname: "localhost",
  pool_size: 10
