defmodule Data.Repo.Migrations.AddUniqueConstraintToProjects do
  use Ecto.Migration

  def change do
    create unique_index(:projects, :url, name: :project_url_index)
  end
end
