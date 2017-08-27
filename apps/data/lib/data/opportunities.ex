defmodule Data.Opportunities do
  @moduledoc """
  The public API for `opportunity` resources
  """

  alias Data.{Opportunity, Repo}
  import Ecto.Query, except: [update: 2]

  @defaults %{filters: %{}, include: [], sort_by: :updated_at, page: 1, page_size: 15}

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
    params = map_labels(params)

    %Opportunity{}
    |> Opportunity.changeset(params)
    |> Repo.insert
  end

  def insert_or_update(%{"url" => url} = params) do
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
    params = map_labels(params)

    struct
    |> Opportunity.changeset(params)
    |> Repo.update
  end

  defp filter({field, value}, query) when is_list(value), do: where(query, [o], field(o, ^field) in ^value)
  defp filter({field, value}, query), do: where(query, [o], field(o, ^field) == ^value)

  defp filters(query, filters), do: Enum.reduce(filters, query, &filter/2)

  defp include(results, nil), do: results
  defp include(%{entries: entries} = results, schemas) do
    preloaded = Repo.preload(entries, schemas)
    Map.put(results, :entries, preloaded)
  end

  defp level_mapping, do: Application.get_env(:data, :level_label_mapping)

  defp map_from_labels([], _mapping), do: nil
  defp map_from_labels(labels, mapping) do
    labels = Enum.map(labels, &(&1 |> Map.get("name") |> String.downcase))
    mapping = Enum.find(mapping, fn {_, mappings} -> length(mappings -- (mappings -- labels)) != 0 end)

    case mapping do
      {level, _} -> level
      _ -> nil
    end
  end

  defp map_labels(%{"labels" => labels} = params) do
    params
    |> Map.put("level", map_from_labels(labels, level_mapping()))
    |> Map.put("type", map_from_labels(labels, type_mapping()))
  end

  defp map_labels(params), do: params

  defp type_mapping, do: Application.get_env(:data, :type_label_mapping)
end
