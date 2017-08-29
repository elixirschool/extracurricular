defmodule Data.Factory do
  use ExMachina.Ecto, repo: Data.Repo

  alias Data.{Opportunity, Project}

  def project_factory do
    %Project{
      name: "Example Project",
      tags: ["authentication", "web"],
      url: sequence("https://example.com")
    }
  end

  def opportunity_factory do
    %Opportunity{
      level: 1,
      title: "Example Opportunity",
      url: sequence("https://example.com/tracker/"),
      project: build(:project)
    }
  end
end
