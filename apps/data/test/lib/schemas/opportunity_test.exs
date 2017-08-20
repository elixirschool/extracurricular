defmodule Data.OpportunityTest do
  use Data.DataCase

  import Data.Factory

  alias Data.Opportunity

  test "opportunity is invalid without a title" do
    changeset = Opportunity.changeset(%Opportunity{}, %{project: build(:project), url: "https://example.com/tracker/1"})
    refute changeset.valid?
  end

  test "opportunity is invalid without a url" do
    changeset = Opportunity.changeset(%Opportunity{}, %{project: build(:project), title: "Example Opportunity"})
    refute changeset.valid?
  end

  test "opportunity is valid" do
    attributes = %{project: build(:project), title: "Example Opportunity", url: "https://example.com/tracker/1"}
    changeset = Opportunity.changeset(%Opportunity{}, attributes)
    assert changeset.valid?
  end

  test "opportunity level is optional but must be inclusive" do
    attributes = %{project: build(:project), title: "Example Opportunity", url: "https://example.com/tracker/1"}

    changeset = Opportunity.changeset(%Opportunity{}, Map.put(attributes, :level, "starter"))
    assert changeset.valid?

    changeset = Opportunity.changeset(%Opportunity{}, Map.put(attributes, :level, "difficult"))
    refute changeset.valid?
  end
end
