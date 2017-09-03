# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Data.Repo.insert!(%Data.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

project_params_1 = %{
  name: "Elixir School",
  tags: ["elixir"],
  url: "https://github.com/elixirschool/elixirschool",
}

project_params_2 = %{
  name: "Extracurricular",
  tags: ["elixir", "open source"],
  url: "https://github.com/elixirschool/extracurricular",
}

project_params_3 = %{
  name: "Appendix",
  tags: ["elixir", "open source", "blog"],
  url: "https://github.com/elixirschool/appendix",
}

{:ok, elixir_school}   = Data.Projects.insert(project_params_1)
{:ok, extracirricular} = Data.Projects.insert(project_params_2)
{:ok, appendix}        = Data.Projects.insert(project_params_3)

opportunity_params_1 = %{
  title: "Understanding GenServers and State",
  level: 1,
  url: "https://github.com/elixirschool/appendix/issues/1",
  project_id: appendix.id
}

opportunity_params_2 = %{
  title: "Translate to pig latin",
  level: 1,
  url: "https://github.com/elixirschool/elixirschool/issues/1",
  project_id: elixir_school.id
}

opportunity_params_3 = %{
  title: "Implement API for sorting",
  level: 1,
  url: "https://github.com/rails/rails/issues/1",
  project_id: extracirricular.id
}

{:ok, _} = Data.Opportunities.insert(opportunity_params_1)
{:ok, _} = Data.Opportunities.insert(opportunity_params_2)
{:ok, _} = Data.Opportunities.insert(opportunity_params_3)
