defmodule Data.Opportunity do
  @moduledoc """
  The schema representation of our `opportunities` table
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Data.Project

  @acceptable_levels Application.get_env(:data, :levels)

  schema "opportunities" do
    field :closed_at, :utc_datetime # when it was closed/completed
    field :level, :string # starter, intermediate, advanced
    field :title, :string
    field :url, :string

    belongs_to :project, Project

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:closed_at, :level, :project_id, :title, :url])
    |> validate_required([:level, :title, :url])
    |> validate_inclusion(:level, @acceptable_levels)
    |> assoc_constraint(:project)
  end
end
