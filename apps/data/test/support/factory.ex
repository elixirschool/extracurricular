defmodule Data.Factory do
  use ExMachina.Ecto, repo: Data.Repo

  alias Data.{Opportunity, Project}

  def project_factory do
    %Project{
      name: "Example Project",
      tags: ["authentication", "web"],
      url: "https://example.com"
    }
  end

  def opportunity_factory do
    %Opportunity{
      level: "starter",
      title: "Example Opportunity",
      url: sequence(&"https://example.com/tracker/#{&1}"),
      project: build(:project)
    }
  end
end
