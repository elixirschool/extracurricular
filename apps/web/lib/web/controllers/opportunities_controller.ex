defmodule Web.OpportunitiesController do
  use Web, :controller

  alias Data.Opportunities

  def index(conn, params) do
    results =
      params
      |> index_filters
      |> Opportunities.all

    render(conn, "opportunities.html", page: results)
  end

  defp current_page(params), do: Map.get(params, "page", 1)

  defp level(%{"level" => ""}), do: [1, 5, 9]
  defp level(params) do
    params
    |> Map.get("level", "1,5,9")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp index_filters(params) do
    %{
      include: :project,
      page: current_page(params),
      filters: %{
        level: level(params)
      }
    }
  end
end
