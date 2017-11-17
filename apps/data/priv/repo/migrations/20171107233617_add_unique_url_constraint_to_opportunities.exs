defmodule Data.Repo.Migrations.AddUniqueUrlConstraintToOpportunities do
  use Ecto.Migration

  def change do
    create unique_index(:opportunities, :url,  name: :opportunity_url_index)
  end
end
