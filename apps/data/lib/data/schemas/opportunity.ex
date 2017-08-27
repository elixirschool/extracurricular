defmodule Data.Opportunity do
  @moduledoc """
  The schema representation of our `opportunities` table
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Data.Project

  @acceptable_levels [1, 5, 9]
  @acceptable_types ["bug", "documentation", "enhancement", "feature"]

  schema "opportunities" do
    field :closed_at, :utc_datetime
    field :level, :integer
    field :title, :string
    field :type, :string
    field :url, :string

    belongs_to :project, Project

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:closed_at, :level, :project_id, :title, :type, :url])
    |> validate_required([:level, :title, :url])
    |> validate_inclusion(:level, @acceptable_levels)
    |> validate_inclusion(:type, @acceptable_types)
    |> assoc_constraint(:project)
  end
end
