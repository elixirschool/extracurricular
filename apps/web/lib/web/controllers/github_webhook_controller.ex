defmodule Web.GitHubWebhookController do
  @moduledoc """
  GitHub Webhook controller is responsible for all incoming requests from GitHub
  """
  use Web, :controller
  require Logger

  alias Data.{Opportunities, Projects}

  plug(:authorize)

  def create(conn, %{"action" => action, "issue" => issue} = issue_event)
      when is_map(issue) and action in ["closed", "labeled", "opened", "reopened"] do
    process_issue(issue_event)

    thank_you(conn)
  end

  def create(conn, _) do
    thank_you(conn)
  end

  def process_issue(%{"issue" => issue, "repository" => %{"html_url" => url, "name" => name}}) do
    case Projects.get(%{url: url}) do
      nil ->
        Logger.warn("Received issue payload for untracked project: #{name} #{url}")

      project ->
        issue
        |> attributes(project)
        |> Opportunities.insert_or_update()
    end
  end

  defp attributes(issue, %{id: project_id}) do
    %{
      "closed_at" => issue["closed_at"],
      "labels" => issue["labels"],
      "project_id" => project_id,
      "title" => issue["title"],
      "url" => issue["html_url"]
    }
  end

  defp authorize(conn, _opts) do
    conn
    |> Plug.Conn.get_req_header("x-hub-signature")
    |> project_for_token
    |> handle_request(conn)
  end

  defp handle_request(nil, conn), do: thank_you(conn)
  defp handle_request(_project, conn), do: conn

  defp project_for_token([]), do: nil
  defp project_for_token([api_token | _]), do: Projects.get(%{api_token: api_token})

  defp thank_you(conn) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json")
    |> send_resp(201, Poison.encode!(%{msg: "thank you"}))
    |> halt
  end
end
