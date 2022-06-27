defmodule VisitApi.Visits.Visit do
  use Ecto.Schema
  import Ecto.Changeset

  alias VisitApi.Accounts
  alias VisitApi.Accounts.User

  schema "visits" do
    field :member_user_id, :binary
    field :minutes, :integer
    field :requested_on, :utc_datetime
    field :visit_date, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(visit, attrs) do
    # IO.inspect("before visit")
    # IO.inspect(visit)
    # IO.inspect("before attrs")
    # IO.inspect(attrs)

    visit
    |> cast(attrs, [:member_user_id, :requested_on, :visit_date, :minutes])
    |> validate_required([:member_user_id, :requested_on, :visit_date, :minutes])
    |> validate_minutes()
  end

  defp validate_minutes(%Ecto.Changeset{valid?: true} = changeset) do
    minutes_requested = get_field(changeset, :minutes)
    user_id = get_field(changeset, :member_user_id)
    user = Accounts.get_user!(user_id)

    validate_minutes(changeset, minutes_requested, user.minutes_balance)
  end

  defp validate_minutes(changeset) do
    changeset
  end

  defp validate_minutes(changeset, minutes_requested, user_balance) when minutes_requested > user_balance do
    add_error(changeset, :not_enough_minutes, "Sorry, you do not have enough minutes.")
  end

  defp validate_minutes(changeset, _, _) do
    changeset
  end

end
