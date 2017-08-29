defmodule Data.OpportunitiesTest do
  use Data.DataCase

  import Data.Factory

  alias Data.Opportunities

  test "inserts new opportunity when valid" do
    attributes = %{
      level: 1,
      project_id: insert(:project).id,
      title: "Example Opportunity",
      url: "https://example.com/tracker/1"
    }

    assert {:ok, %{id: _id}} = Opportunities.insert(attributes)
  end

  test "gets opportunity by attributes" do
    %{url: url} = insert(:opportunity)
    assert %{id: _id} = Opportunities.get(%{url: url})
  end

  test "sort opportunities" do
    insert(:opportunity, title: "B Example")
    insert(:opportunity, title: "C Example")
    insert(:opportunity, title: "A Example")
    %{entries: opportunities} = Opportunities.all(%{sort_by: :title})

    assert [%{title: "A Example"}, %{title: "B Example"}, %{title: "C Example"}] = opportunities
  end

  test "updates opportunity by id" do
    %{id: id} = insert(:opportunity)
    new_url = "https://example.com/new"
    assert {:ok, %{id: _id, url: ^new_url}} = Opportunities.update(id, %{url: new_url})
  end

  test "updates a given opportunity" do
    opportunity = insert(:opportunity)
    new_url = "https://example.com/new"
    assert {:ok, %{id: _id, url: ^new_url}} = Opportunities.update(opportunity, %{url: new_url})
  end

  test "oppportunties are paginated" do
    insert_pair(:opportunity)

    result = Opportunities.all()

    assert result.page_number == 1
    assert result.page_size == 25
    assert result.total_pages == 1
    assert result.total_entries == 2
  end
end
