defmodule Data.Repo.Migrations.AddOpportunityTypeAndProjectToken do
  use Ecto.Migration

  def change do
    alter table(:opportunities) do
      add :type, :string, null: true
    end

    alter table(:projects) do
      add :api_token, :string
    end

    create unique_index(:projects, [:api_token])
  end
end
