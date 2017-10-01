defmodule Web.OpportunitiesController do
  use Web, :controller

  alias Data.Opportunities
  @allowed_sorts ~w(difficulty inserted_at title)

  def index(conn, params) do
    page =
      params
      |> index_filters
      |> sort_by(params)
      |> Opportunities.all

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, format_json(page))
  end

  defp current_page(params), do: Map.get(params, "page", 1)

  defp format_json(page) do
    entries = Enum.map(page.entries, &format_opportunity/1)

    json = %{
      entries: entries,
      page_number: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
      total_entries: page.total_entries
    }

    Poison.encode!(json)
  end

  defp format_opportunity(opportunity) do
    project = Map.take(opportunity.project, [:name, :id, :tags, :url])

    opportunity
    |> Map.take([:level, :id, :title, :url])
    |> Map.merge(%{project: project})
  end

  defp level(%{"levels" => ""}), do: [1, 5, 9]
  defp level(params) do
    params
    |> Map.get("levels", "1,5,9")
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
