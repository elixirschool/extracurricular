defmodule Data.Repo.Migrations.CreateOpportunityAndProjectTables do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string, null: false
      add :tags, {:array, :string}, default: []
      add :url, :string, null: false
    end

    create table(:opportunities) do
      add :title, :string, null: false
      add :level, :string
      add :project_id, references(:projects), null: false
      add :url, :string, null: false
      add :completed_at, :utc_datetime

      timestamps()
    end
  end
end
