defmodule VisitApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias VisitApi.Visits.Visit

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :minutes_balance, :integer
    has_many(:visits, Visit, on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :minutes_balance])
    |> validate_required([:first_name, :last_name, :email, :minutes_balance])
  end
end
