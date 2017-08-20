defmodule Data.Project do
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
  end
end
