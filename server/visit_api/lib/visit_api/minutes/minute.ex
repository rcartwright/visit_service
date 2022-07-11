defmodule VisitApi.Minutes.Minute do
  use Ecto.Schema
  import Ecto.Changeset
  alias VisitApi.Accounts.User

  @foreign_key_type :binary_id

  schema "minutes" do
    field :available_balance, :integer
    field :balance, :integer
    belongs_to(:user, User, foreign_key: :user_id)

    timestamps()
  end

  @doc false
  def changeset(minute, attrs) do
    minute
    |> cast(attrs, [:user_id, :available_balance, :balance])
    |> validate_required([:user_id, :available_balance, :balance])
    |> assoc_constraint(:user)
  end
end
