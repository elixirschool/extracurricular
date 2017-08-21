defmodule Data.Projects do
  @moduledoc """
  The public API for `project` resources
  """

  alias Data.{Project, Repo}

  def all, do: Repo.all(Project)

  def get(params), do: Repo.get_by(Project, params)

  def get_or_insert(params) do
    case get(params) do
      nil -> insert(params)
      project -> {:ok, project}
    end
  end

  def insert(params) do
    %Project{}
    |> Project.changeset(params)
    |> Repo.insert
  end

  def update(id, params) when is_integer(id) do
    Project
    |> Repo.get(id)
    |> update(params)
  end

  def update(struct, params) do
    struct
    |> Project.changeset(params)
    |> Repo.update
  end
end
