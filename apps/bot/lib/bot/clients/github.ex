defmodule Bot.Client.GitHub do
  @moduledoc """
  GitHub API client
  """

  use HTTPoison.Base

  def process_response_body(body), do: Poison.decode!(body)

  defp process_request_headers(headers) do
    [{"Accept", "application/vnd.github.v3+json"}] ++ headers
  end

  def process_url(url), do: api_url() <> url

  defp api_url, do: Application.get_env(:bot, :github_url)
end
