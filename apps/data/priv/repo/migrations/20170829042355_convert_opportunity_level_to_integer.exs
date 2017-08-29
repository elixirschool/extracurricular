defmodule Data.Repo.Migrations.ConvertOpportunityLevelToInteger do
  use Ecto.Migration

  def change do
    execute "UPDATE opportunities set level = case when level = 'starter' then '1' when level = 'beginner' then '1' when level = 'intermediate' then '5' when level = 'advanced' then '9' else '-1' end;"
    execute "ALTER TABLE opportunities ALTER COLUMN level TYPE integer USING (level::integer);"
  end
end
