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

opportunties =
  [%{
    title: "Understanding GenServers and State",
    level: 2,
    url: "https://github.com/elixirschool/appendix/issues/1",
    project_id: appendix.id
  }, %{
    title: "Translate to pig latin",
    level: 1,
    url: "https://github.com/elixirschool/elixirschool/issues/1",
    project_id: elixir_school.id
  }, %{
    title: "Pipelines in Elixir",
    level: 1,
    url: "https://github.com/elixirschool/appendix/issues/1",
    project_id: appendix.id
  }, %{
    title: "Implement API for sorting",
    level: 5,
    url: "https://github.com/elixirschool/extracirricular/issues/1",
    project_id: extracirricular.id
  }, %{
    title: "Fix grammar in Basic lesssons",
    level: 1,
    url: "https://github.com/elixirschool/elixirschool/issues/1",
    project_id: elixir_school.id
  }, %{
    title: "Support JSON API for controller responses",
    level: 9,
    url: "https://github.com/elixirschool/extracirricular/issues/1",
    project_id: extracirricular.id
  }, %{
    title: "Add new lesson on Registry",
    level: 5,
    url: "https://github.com/elixirschool/elixirschool/issues/1",
    project_id: elixir_school.id
  }]

Enum.each(opportunties, &Data.Opportunities.insert/1)
