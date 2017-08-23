defmodule Web.OpportunitiesControllerTest do
  use Web.ConnCase

  import Data.Factory

  alias Data.Opportunities

  test "GET /list", %{conn: conn} do
    attributes = %{
      level: "beginner",
      project_id: insert(:project).id,
      title: "Example Opportunity",
      url: "https://example.com/tracker/1"
    }
    Opportunities.insert(attributes)
    Opportunities.insert(%{attributes | title: "Another Opportunity"})

    conn = get conn, "/list"
    assert html_response(conn, 200) =~ "Example Opportunity"
    assert html_response(conn, 200) =~ "Another Opportunity"
  end
end
