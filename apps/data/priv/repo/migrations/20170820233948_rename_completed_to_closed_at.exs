defmodule Data.Repo.Migrations.RenameCompletedToClosedAt do
  use Ecto.Migration

  def change do
    rename table(:opportunities), :completed_at, to: :closed_at
  end
end
