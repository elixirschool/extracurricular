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

project_params_1 = %Data.Project{
  name: "Elixir School",
  tags: ["elixir"],
  url: "https://github.com/elixirschool/elixirschool",
  api_token: "dummy1",
}

project_params_2 = %Data.Project{
  name: "Extracurricular",
  tags: ["elixir", "open source"],
  url: "https://github.com/elixirschool/extracurricular",
  api_token: "dummy2",
}

project_params_3 = %Data.Project{
  name: "Appendix",
  tags: ["elixir", "open source", "blog"],
  url: "https://github.com/elixirschool/appendix",
  api_token: "dummy3",
}

{:ok, elixir_school}   = Data.Repo.insert(project_params_1)
{:ok, extracirricular} = Data.Repo.insert(project_params_2)
{:ok, appendix}        = Data.Repo.insert(project_params_3)

opportunties =
  [%Data.Opportunity{
    title: "Understanding GenServers and State",
    level: 2,
    url: "https://github.com/elixirschool/appendix/issues/1",
    project_id: appendix.id
  }, %Data.Opportunity{
    title: "Translate to pig latin",
    level: 1,
    url: "https://github.com/elixirschool/elixirschool/issues/1",
    project_id: elixir_school.id
  }, %Data.Opportunity{
    title: "Pipelines in Elixir",
    level: 1,
    url: "https://github.com/elixirschool/appendix/issues/1",
    project_id: appendix.id
  }, %Data.Opportunity{
    title: "Implement API for sorting",
    level: 5,
    url: "https://github.com/elixirschool/extracirricular/issues/1",
    project_id: extracirricular.id
  }, %Data.Opportunity{
    title: "Fix grammar in Basic lesssons",
    level: 1,
    url: "https://github.com/elixirschool/elixirschool/issues/1",
    project_id: elixir_school.id
  }, %Data.Opportunity{
    title: "Support JSON API for controller responses",
    level: 9,
    url: "https://github.com/elixirschool/extracirricular/issues/1",
    project_id: extracirricular.id
  }, %Data.Opportunity{
    title: "Add new lesson on Registry",
    level: 5,
    url: "https://github.com/elixirschool/elixirschool/issues/1",
    project_id: elixir_school.id
  }]

Enum.each(opportunties, &Data.Repo.insert/1)
