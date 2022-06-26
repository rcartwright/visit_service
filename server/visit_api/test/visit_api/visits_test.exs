defmodule VisitApi.VisitsTest do
  use VisitApi.DataCase

  alias VisitApi.Visits

  describe "visits" do
    alias VisitApi.Visits.Visit

    @valid_attrs %{member_user_id: "some member_user_id", minutes: 42, requested_on: "2010-04-17T14:00:00Z", visit_date: "2010-04-17T14:00:00Z"}
    @update_attrs %{member_user_id: "some updated member_user_id", minutes: 43, requested_on: "2011-05-18T15:01:01Z", visit_date: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{member_user_id: nil, minutes: nil, requested_on: nil, visit_date: nil}

    def visit_fixture(attrs \\ %{}) do
      {:ok, visit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Visits.create_visit()

      visit
    end

    # test "list_visits/0 returns all visits" do
    #   visit = visit_fixture()
    #   assert Visits.list_visits() == [visit]
    # end

    # test "get_visit!/1 returns the visit with given id" do
    #   visit = visit_fixture()
    #   assert Visits.get_visit!(visit.id) == visit
    # end

    # test "create_visit/1 with valid data creates a visit" do
    #   assert {:ok, %Visit{} = visit} = Visits.create_visit(@valid_attrs)
    #   assert visit.member_user_id == "some member_user_id"
    #   assert visit.minutes == 42
    #   assert visit.requested_on == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    #   assert visit.visit_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    # end

    # test "create_visit/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Visits.create_visit(@invalid_attrs)
    # end

    # test "update_visit/2 with valid data updates the visit" do
    #   visit = visit_fixture()
    #   assert {:ok, %Visit{} = visit} = Visits.update_visit(visit, @update_attrs)
    #   assert visit.member_user_id == "some updated member_user_id"
    #   assert visit.minutes == 43
    #   assert visit.requested_on == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    #   assert visit.visit_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    # end

    # test "update_visit/2 with invalid data returns error changeset" do
    #   visit = visit_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Visits.update_visit(visit, @invalid_attrs)
    #   assert visit == Visits.get_visit!(visit.id)
    # end

    # test "delete_visit/1 deletes the visit" do
    #   visit = visit_fixture()
    #   assert {:ok, %Visit{}} = Visits.delete_visit(visit)
    #   assert_raise Ecto.NoResultsError, fn -> Visits.get_visit!(visit.id) end
    # end

    # test "change_visit/1 returns a visit changeset" do
    #   visit = visit_fixture()
    #   assert %Ecto.Changeset{} = Visits.change_visit(visit)
    # end
  end
end
