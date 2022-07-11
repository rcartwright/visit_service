defmodule VisitApi.MinutesTest do
  use VisitApi.DataCase

  alias VisitApi.Minutes
  alias VisitApi.Accounts

  describe "minutes" do
    alias VisitApi.Minutes.Minute

    #@update_attrs %{available_balance: 43, balance: 43, user_id: UUID.uuid1()}
    @invalid_attrs %{available_balance: nil, balance: nil, user_id: nil}
    @create_user_attrs %{
      email: "some email",
      first_name: "some first_name",
      last_name: "some last_name",
      minutes_balance: 45
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@create_user_attrs)
        |> Accounts.create_user()

      user
    end

    def minute_fixture(attrs \\ %{}, user) do
      valid_attrs = %{available_balance: 42, balance: 42, user_id: user.id}
      {:ok, minute} =
        attrs
        |> Enum.into(valid_attrs)
        |> Minutes.create_minute()

      minute
    end

    test "list_minutes/0 returns all minutes" do
      user = user_fixture()
      minute = minute_fixture(user)
      assert Minutes.list_minutes() == [minute]
    end

    test "get_minute!/1 returns the minute with given id" do
      user = user_fixture()
      minute = minute_fixture(user)
      assert Minutes.get_minute!(minute.id) == minute
    end

    test "create_minute/1 with valid data creates a minute" do
      user = user_fixture()
      valid_attrs = %{available_balance: 42, balance: 42, user_id: user.id}
      assert {:ok, %Minute{} = minute} = Minutes.create_minute(valid_attrs)
      assert minute.available_balance == 42
      assert minute.balance == 42
      assert minute.user_id == user.id
    end

    # test "create_minute/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Minutes.create_minute(@invalid_attrs)
    # end

    # test "update_minute/2 with valid data updates the minute" do
    #   minute = minute_fixture()
    #   assert {:ok, %Minute{} = minute} = Minutes.update_minute(minute, @update_attrs)
    #   assert minute.available_balance == 43
    #   assert minute.balance == 43
    #   assert minute.user_id == "some updated user_id"
    # end

    # test "update_minute/2 with invalid data returns error changeset" do
    #   minute = minute_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Minutes.update_minute(minute, @invalid_attrs)
    #   assert minute == Minutes.get_minute!(minute.id)
    # end

    # test "delete_minute/1 deletes the minute" do
    #   minute = minute_fixture()
    #   assert {:ok, %Minute{}} = Minutes.delete_minute(minute)
    #   assert_raise Ecto.NoResultsError, fn -> Minutes.get_minute!(minute.id) end
    # end

    # test "change_minute/1 returns a minute changeset" do
    #   minute = minute_fixture()
    #   assert %Ecto.Changeset{} = Minutes.change_minute(minute)
    # end
  end
end
