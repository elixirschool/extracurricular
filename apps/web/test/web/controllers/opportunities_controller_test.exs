defmodule Web.OpportunitiesControllerTest do
  use Web.ConnCase

  alias Data.{Opportunities, Projects}

  test "GET /opportunities", %{conn: conn} do
    {:ok, %{id: project_id}} = Projects.insert(%{name: "Example Project", url: "example.com"})

    Opportunities.insert(%{
      level: 1,
      project_id: project_id,
      title: "Example Opportunity",
      url: "https://example.com/tracker/1"
    })

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> get("/opportunities")

    assert %{"entries" => [
      %{"level"   => 1,
        "project" => %{"id" => ^project_id},
        "title"   => "Example Opportunity",
        "url"     => "https://example.com/tracker/1"}]} = json_response(conn, 200)
  end

  test "GET /opportunities with filters", %{conn: conn} do
    {:ok, %{id: project_id}} = Projects.insert(%{name: "Example Project", url: "example.com"})

    Opportunities.insert(%{
      level: 1,
      project_id: project_id,
      title: "Example Opportunity",
      url: "https://example.com/tracker/1"
    })

    Opportunities.insert(%{
      level: 5,
      project_id: project_id,
      title: "Another Opportunity",
      url: "https://example.com/tracker/2"
    })

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> get("/opportunities?levels=5")

    assert %{"entries" => [
      %{"level"   => 5,
        "project" => %{"id" => ^project_id},
        "title"   => "Another Opportunity",
        "url"     => "https://example.com/tracker/2"}]} = json_response(conn, 200)
  end
end
