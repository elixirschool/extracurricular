defmodule Bot.Client.GitHub do
  @moduledoc """
  GitHub API client
  """

  use HTTPoison.Base

  import Appsignal.Instrumentation.Helpers, only: [instrument: 4]

  def process_response_body(body), do: Poison.decode!(body)

  defp process_request_headers(headers) do
    [{"Accept", "application/vnd.github.v3+json"}] ++ headers
  end

  def process_url(url), do: api_url() <> url

  def request(method, url, headers, body, options) do
    transaction =
      Appsignal.Transaction.start(Appsignal.Transaction.generate_id(), :background_task)

    transaction
    |> Appsignal.Transaction.set_action("GitHub/request")
    |> Appsignal.Transaction.set_sample_data("environment", %{request_path: url})

    result =
      instrument(transaction, "github.request_api", "Requesting GitHub API", fn ->
        super(method, url, headers, body, options)
      end)

    Appsignal.Transaction.finish(transaction)
    :ok = Appsignal.Transaction.complete(transaction)

    result
  end

  defp api_url, do: Application.get_env(:bot, :github_url)
end
