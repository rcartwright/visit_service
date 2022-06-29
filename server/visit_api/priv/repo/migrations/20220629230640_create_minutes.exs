defmodule VisitApi.Repo.Migrations.CreateMinutes do
  use Ecto.Migration

  def change do
    create table(:minutes) do
      add :user_id, references(:users, type: :binary_id, column: :id, on_delete: :delete_all)
      add :available_balance, :integer
      add :balance, :integer

      timestamps()
    end

  end
end
