defmodule Web.OpportunitiesController do
  use Web, :controller

  alias Data.Opportunities
  @allowed_sorts ~w(difficulty inserted_at title)

  def index(conn, params) do
    results =
      params
      |> index_filters
      |> sort_by(params)
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

  defp sort_by(filters, %{"sort_by" => sort_by}) when sort_by in @allowed_sorts do 
    Map.put(filters, :sort_by, String.to_atom(sort_by))
  end
  defp sort_by(filters, _params), do: filters
end
