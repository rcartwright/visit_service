defmodule VisitApi.Repo.Migrations.AddModelRelation do
  use Ecto.Migration

  def change do
    alter table(:visits) do
      remove :member_user_id
      add :member_user_id, references(:users, type: :binary_id, column: :id, on_delete: :delete_all)
    end
  end
end
