defmodule Data.Opportunities do
  @moduledoc """
  The public API for `opportunity` resources
  """

  alias Data.{Opportunity, Repo}
  require Ecto.Query

  @defaults %{sort_by: :inserted_at, page_size: 25}

  def all(opts \\ %{}) do
    opts = Map.merge(@defaults, opts)

    Opportunity 
    |> Ecto.Query.order_by(^opts.sort_by) 
    |> Repo.paginate(page_size: opts.page_size)    
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
end
