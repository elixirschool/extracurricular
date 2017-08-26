defmodule Data.Project do
  @moduledoc """
  The schema representation of our `projects` table
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "projects" do
    field :name, :string
    field :tags, {:array, :string}
    field :url, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :tags, :url])
    |> validate_required([:name, :url])
    |> unique_constraint(:url, message: "A project with this URL already exists", name: "project_url_index")
  end
end
