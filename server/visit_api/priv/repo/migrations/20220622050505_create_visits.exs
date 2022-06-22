defmodule VisitApi.Repo.Migrations.CreateVisits do
  use Ecto.Migration

  def change do
    create table(:visits) do
      add :member_user_id, :binary
      add :requested_on, :utc_datetime
      add :visit_date, :utc_datetime
      add :minutes, :integer

      timestamps()
    end

  end
end
