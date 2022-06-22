defmodule VisitApi.Visits.Visit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "visits" do
    field :member_user_id, :binary
    field :minutes, :integer
    field :requested_on, :utc_datetime
    field :visit_date, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(visit, attrs) do
    visit
    |> cast(attrs, [:member_user_id, :requested_on, :visit_date, :minutes])
    |> validate_required([:member_user_id, :requested_on, :visit_date, :minutes])
  end
end
