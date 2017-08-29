defmodule Web.OpportunitiesControllerTest do
  use Web.ConnCase

  alias Data.{Opportunities, Projects}

  test "GET /", %{conn: conn} do
    {:ok, %{id: project_id}} = Projects.insert(%{name: "Example Project", url: "example.com"})

    attributes = %{
      level: 1,
      project_id: project_id,
      title: "Example Opportunity",
      url: "https://example.com/tracker/1"
    }

    Opportunities.insert(attributes)
    Opportunities.insert(%{attributes | title: "Another Opportunity"})

    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Example Opportunity"
    assert html_response(conn, 200) =~ "Another Opportunity"
  end
end
