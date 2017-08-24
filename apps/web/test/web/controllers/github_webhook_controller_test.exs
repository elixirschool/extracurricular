defmodule Web.GitHubWebhookControllerTest do
  use Web.ConnCase

  alias Data.Opportunities

  test "POST /webhooks/github", %{conn: conn} do
    # Fields omitted from official webhook payload for brevity

    body = %{
      "action": "opened",
      "issue": %{
        "html_url": "https://github.com/repos/elixirschool/extracurricular/issues/2",
        "title": "This is a test",
        "user": %{
          "login": "doomspork",
        },
        "labels": [
          %{
            "name": "Kind:Starter",
            "color": "fc2929",
            "default": true
          }
        ],
        "state": "open",
        "closed_at": nil
      },
      "repository": %{
        "name": "public-repo",
        "html_url": "https://.github.com/repos/elixirschool/extracurricular"
      },
      "sender": %{
        "login": "doomspork"
      }
    }

    conn =
      conn
      |> put_req_header("content-type", "application/json")
      |> post("/webhooks/github", Poison.encode!(body))

    json_response(conn, 201)

    opportunities = Opportunities.all()
    assert length(opportunities.entries) == 1
  end
end
