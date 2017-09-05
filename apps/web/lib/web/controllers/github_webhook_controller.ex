defmodule Web.GitHubWebhookController do
  @moduledoc """
  GitHub Webhook controller is responsible for all incoming requests from GitHub
  """
  use Web, :controller
  require Logger

  alias Data.{Opportunities, Projects}

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
      nil -> Logger.warn("Received issue payload for untracked project: #{name} #{url}")
      project ->
        issue
        |> attributes(project)
        |> Opportunities.insert_or_update
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


  defp thank_you(conn) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json")
    |> send_resp(201, Poison.encode!(%{msg: "thank you"}))
  end
end
