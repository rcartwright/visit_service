defmodule VisitApi.Visits.Visit do
  use Ecto.Schema
  import Ecto.Changeset

  alias VisitApi.Accounts
  alias VisitApi.Accounts.User
  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "visits" do
    field :minutes, :integer
    field :requested_on, :utc_datetime
    field :visit_date, :utc_datetime
    belongs_to(:user, User, foreign_key: :member_user_id)

    timestamps()
  end

  @doc false
  def changeset(visit, attrs) do
    visit
    |> cast(attrs, [:member_user_id, :requested_on, :visit_date, :minutes])
    |> validate_required([:member_user_id, :requested_on, :visit_date, :minutes])
    |> validate_minutes()
  end

  @doc """
  This is here so that members cannot request visits if they do not have enough minutes in their balance.
  """
  def validate_minutes(%Ecto.Changeset{valid?: true} = changeset) do
    minutes_requested = get_field(changeset, :minutes)
    user_id = get_field(changeset, :member_user_id)
    user = Accounts.get_user!(user_id)

    validate_minutes(changeset, minutes_requested, user.minutes_balance)
  end

  def validate_minutes(changeset) do
    changeset
  end

  defp validate_minutes(changeset, minutes_requested, user_balance) when minutes_requested > user_balance do
    add_error(changeset, :not_enough_minutes, "Sorry, you do not have enough minutes.")
  end

  defp validate_minutes(changeset, _, _) do
    changeset
  end

end
