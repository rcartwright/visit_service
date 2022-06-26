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
   # |> IO.inspect()
    |> validate_minutes()
  end

  # def has_enough_minutes(%Ecto.Changeset{valid?: true} = changeset, attrs) do
  #  # IO.inspect("attrs", attrs)
  #   user = Accounts.get_user!(attrs.member_user_id)
  #   case attrs.minutes <= user.minutes_balance do
  #     true -> {:ok, attrs}
  #     false -> changeset
  #   end
  # end

  # def has_enough_minutes(%Ecto.Changeset{valid?: false} = changeset, attrs) do
  #   changeset
  # end

  defp validate_minutes(changeset) do
    IO.inspect("beginning of validate_minutes")
    IO.inspect(changeset)
    #Ecto.Changeset<
    #looks like below
  # action: nil,
  # changes: %{
  #   minutes: 10,
  #   requested_on: ~U[2010-04-17 14:00:00Z],
  #   visit_date: ~U[2010-04-17 14:00:00Z]
  # },
  # errors: [member_user_id: {"is invalid", [type: :binary, validation: :cast]}],
  # data: #VisitApi.Visits.Visit<>,
  # valid?: false
    minutes_requested = get_field(changeset, :minutes)
    user_id = get_field(changeset, :member_user_id)
    IO.inspect(user_id)
    user = Accounts.get_user!(user_id)



    validate_minutes(changeset, minutes_requested, user.minutes)
  end

  defp validate_minutes(changeset, minutes_requested, user_balance) when minutes_requested > user_balance do
    add_error(changeset, :not_enough_minutes, "Sorry, you do not have enough minutes.")
  end

  defp validate_minutes(changeset, _, _), do: changeset

end
