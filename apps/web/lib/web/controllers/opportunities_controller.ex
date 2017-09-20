defmodule Web.OpportunitiesController do
  use Web, :controller

  alias Data.Opportunities

  def index(conn, params) do
    page =
      params
      |> index_filters
      |> Opportunities.all

    send_resp(conn, 200, format_json(page))
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
    project = Map.take(opportunity.project, [:name, :id, :tags])

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
end
