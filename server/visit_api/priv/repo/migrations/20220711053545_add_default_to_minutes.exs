defmodule VisitApi.Repo.Migrations.AddDefaultToMinutes do
  use Ecto.Migration

  def change do
    alter table(:minutes) do
      remove :available_balance
      remove :balance
      add :available_balance, :integer, default: 60
      add :balance, :integer, default: 60
    end
  end
end
