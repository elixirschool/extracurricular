defmodule Data.Repo.Migrations.AddProjectsTimestamps do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      timestamps()
    end
  end
end
