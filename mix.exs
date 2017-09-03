defmodule Extracurricular.Mixfile do
  use Mix.Project

  def project do
    [apps_path: "apps",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     aliases: aliases()]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run apps/data/priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.8.6", only: [:dev, :test], runtime: false}
    ]
  end
end
