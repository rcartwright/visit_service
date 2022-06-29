defmodule VisitApi.Repo.Migrations.ChangeIdTypeOnVisits do
  use Ecto.Migration

  def change do
    alter table(:visits, primary_key: false) do
      remove :id
      add :id, :binary_id, primary_key: true
    end
  end
end
