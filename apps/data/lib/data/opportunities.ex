defmodule Data.Opportunities do
  @moduledoc """
  The public API for `opportunity` resources
  """

  alias Data.{Opportunity, Repo}
  import Ecto.Query, except: [update: 2]

  @defaults %{filters: %{}, include: [], sort_by: :inserted_at, page: 1, page_size: 5}

  def all(opts \\ %{}) do
    opts = Map.merge(@defaults, opts)

    Opportunity
    |> Ecto.Query.order_by(^opts.sort_by)
    |> filters(opts.filters)
    |> Repo.paginate(page: opts.page, page_size: opts.page_size)
    |> include(opts.include)
  end

  def get(params), do: Repo.get_by(Opportunity, params)

  def insert(params) do
    %Opportunity{}
    |> Opportunity.changeset(params)
    |> Repo.insert
  end

  def insert_or_update(%{url: url} = params) do
    case get(%{url: url}) do
      nil -> insert(params)
      opportunity -> update(opportunity, params)
    end
  end

  def update(id, params) when is_integer(id) do
    Opportunity
    |> Repo.get(id)
    |> update(params)
  end

  def update(struct, params) do
    struct
    |> Opportunity.changeset(params)
    |> Repo.update
  end

  defp filter({field, value}, query) when is_list(value), do: where(query, [o], field(o, ^field) in ^value)

  defp filters(query, filters), do: Enum.reduce(filters, query, &filter/2)

  defp include(results, nil), do: results
  defp include(%{entries: entries} = results, schemas) do
    preloaded = Repo.preload(entries, schemas)
    Map.put(results, :entries, preloaded)
  end
end
