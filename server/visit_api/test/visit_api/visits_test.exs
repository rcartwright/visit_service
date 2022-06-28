defmodule VisitApi.VisitsTest do
  use VisitApi.DataCase

  alias VisitApi.Visits
  alias VisitApi.Accounts

  describe "visits" do
    alias VisitApi.Visits.Visit

    @invalid_visit_attrs %{member_user_id: nil, minutes: nil, requested_on: nil, visit_date: nil}
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

    def visit_fixture(attrs \\ %{}, user) do
      valid_attrs = %{
        member_user_id: user.id,
        minutes: 35,
        requested_on: "2010-04-17T14:00:00Z",
        visit_date: "2010-04-17T14:00:00Z"
      }
      {:ok, visit} =
        attrs
        |> Enum.into(valid_attrs)
        |> Visits.create_visit()

      visit
    end

    test "list_visits/0 returns all visits" do
      user = user_fixture()
      visit = visit_fixture(user)
      assert Visits.list_visits() == [visit]
    end

    test "get_visit!/1 returns the visit with given id" do
      user = user_fixture()
      visit = visit_fixture(user)
      assert Visits.get_visit!(visit.id) == visit
    end

    test "create_visit/1 with valid data creates a visit" do
      user = user_fixture()
      valid_attrs = %{
        member_user_id: user.id,
        minutes: 42,
        requested_on: "2010-04-17T14:00:00Z",
        visit_date: "2010-04-17T14:00:00Z"
      }
      assert {:ok, %Visit{} = visit} = Visits.create_visit(valid_attrs)
      assert visit.member_user_id == user.id
      assert visit.minutes == 42
      assert visit.requested_on == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert visit.visit_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_visit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Visits.create_visit(@invalid_visit_attrs)
    end

    test "update_visit/2 with valid data updates the visit" do
      user = user_fixture()
      visit = visit_fixture(user)
      valid_update_attrs = %{
        member_user_id: user.id,
        minutes: 42,
        requested_on: "2010-04-17T14:00:00Z",
        visit_date: "2010-04-17T14:00:00Z"
      }
      assert {:ok, %Visit{} = visit} = Visits.update_visit(visit, valid_update_attrs)
      assert visit.member_user_id == user.id
      assert visit.minutes == 42
      assert visit.requested_on == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert visit.visit_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "update_visit/2 with invalid data returns error changeset" do
      user = user_fixture()
      visit = visit_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Visits.update_visit(visit, @invalid_visit_attrs)
      assert visit == Visits.get_visit!(visit.id)
    end

    test "delete_visit/1 deletes the visit" do
      user = user_fixture()
      visit = visit_fixture(user)
      assert {:ok, %Visit{}} = Visits.delete_visit(visit)
      assert_raise Ecto.NoResultsError, fn -> Visits.get_visit!(visit.id) end
    end

    test "change_visit/1 returns a visit changeset" do
      user = user_fixture()
      visit = visit_fixture(user)
      assert %Ecto.Changeset{} = Visits.change_visit(visit)
    end
  end
end
