defmodule Data.OpportunityTest do
  use Data.DataCase

  import Data.Factory

  alias Data.Opportunity

  test "opportunity is invalid without a title" do
    attributes = %{level: "starter", project: insert(:project).id, url: "https://example.com/tracker/1"}
    changeset = Opportunity.changeset(%Opportunity{}, attributes)
    refute changeset.valid?
  end

  test "opportunity is invalid without a url" do
    attributes = %{project: insert(:project).id, title: "Example Opportunity"}
    changeset = Opportunity.changeset(%Opportunity{}, attributes)
    refute changeset.valid?
  end

  test "opportunity is invalid without a level" do
    attributes = %{project: insert(:project).id, title: "Example Opportunity", url: "https://example.com/tracker/1"}
    changeset = Opportunity.changeset(%Opportunity{}, attributes)
    refute changeset.valid?
  end

  test "opportunity is valid" do
    attributes = %{
      level: 1,
      project_id: insert(:project).id,
      title: "Example Opportunity",
      url: "https://example.com/tracker/1"
    }

    changeset = Opportunity.changeset(%Opportunity{}, attributes)
    assert changeset.valid?
  end
end
