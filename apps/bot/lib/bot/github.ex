defmodule Bot.GitHub do
  @moduledoc """
  GitHub leverages the HTTPoison client under the hood to provide a clean API for bot applications who need
  to interact with GitHub.
  """

  alias Bot.Client.GitHub

  def issues(repo, page \\ 1) do
    {body, next_page_number} =
      "/repos/#{repo}/issues?assignee=none&state=open&page=#{page}"
      |> GitHub.get
      |> response
      |> filter_out_pull_requests()

    if next_page_number <= page do
      body
    else
      body ++ issues(repo, next_page_number)
    end
  end

  defp filter_out_pull_requests({body, next_page_number}) do
    {Enum.filter(body, &(!Map.has_key?(&1, "pull_request"))), next_page_number}
  end

  defp next_page(headers) do
    headers
    |> Enum.find(&("Link" == elem(&1, 0)))
    |> parse_link_header
  end

  def parse_link_header(nil), do: 1
  def parse_link_header({"Link", links}) do
    case Regex.run(~r/page=(\d+)>; rel="next"/, links) do
      [_match, page] -> String.to_integer(page)
      nil -> 1
    end
  end

  defp response({:error, _reason} = err), do: err
  defp response({:ok, %{body: body, headers: headers}}), do: {body, next_page(headers)}
end
