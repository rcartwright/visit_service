defmodule VisitApi.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users, primary_key: false) do
      remove :id
      add :id, :binary_id, primary_key: true
    end
  end
end
