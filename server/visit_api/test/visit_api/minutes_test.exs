defmodule VisitApi.MinutesTest do
  use VisitApi.DataCase

  alias VisitApi.Minutes

  # describe "minutes" do
  #   alias VisitApi.Minutes.Minute

  #   @valid_attrs %{available_balance: 42, balance: 42, user_id: UUID.uuid1()}
  #   @update_attrs %{available_balance: 43, balance: 43, user_id: UUID.uuid1()}
  #   @invalid_attrs %{available_balance: nil, balance: nil, user_id: nil}

  #   def minute_fixture(attrs \\ %{}) do
  #     {:ok, minute} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Minutes.create_minute()

  #     minute
  #   end

  #   test "list_minutes/0 returns all minutes" do
  #     minute = minute_fixture()
  #     assert Minutes.list_minutes() == [minute]
  #   end

  #   test "get_minute!/1 returns the minute with given id" do
  #     minute = minute_fixture()
  #     assert Minutes.get_minute!(minute.id) == minute
  #   end

  #   test "create_minute/1 with valid data creates a minute" do
  #     assert {:ok, %Minute{} = minute} = Minutes.create_minute(@valid_attrs)
  #     assert minute.available_balance == 42
  #     assert minute.balance == 42
  #     assert minute.user_id == "some user_id"
  #   end

  #   test "create_minute/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Minutes.create_minute(@invalid_attrs)
  #   end

  #   test "update_minute/2 with valid data updates the minute" do
  #     minute = minute_fixture()
  #     assert {:ok, %Minute{} = minute} = Minutes.update_minute(minute, @update_attrs)
  #     assert minute.available_balance == 43
  #     assert minute.balance == 43
  #     assert minute.user_id == "some updated user_id"
  #   end

  #   test "update_minute/2 with invalid data returns error changeset" do
  #     minute = minute_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Minutes.update_minute(minute, @invalid_attrs)
  #     assert minute == Minutes.get_minute!(minute.id)
  #   end

  #   test "delete_minute/1 deletes the minute" do
  #     minute = minute_fixture()
  #     assert {:ok, %Minute{}} = Minutes.delete_minute(minute)
  #     assert_raise Ecto.NoResultsError, fn -> Minutes.get_minute!(minute.id) end
  #   end

  #   test "change_minute/1 returns a minute changeset" do
  #     minute = minute_fixture()
  #     assert %Ecto.Changeset{} = Minutes.change_minute(minute)
  #   end
  # end
end
