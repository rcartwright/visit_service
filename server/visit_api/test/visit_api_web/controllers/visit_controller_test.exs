defmodule VisitApiWeb.VisitControllerTest do
  use VisitApiWeb.ConnCase

  alias VisitApi.Visits
  alias VisitApi.Accounts.User
  alias VisitApi.Accounts

  @invalid_visit_attrs %{member_user_id: nil, minutes: nil, requested_on: nil, visit_date: nil}

  @create_user_attrs %{
    email: "some email",
    first_name: "some first_name",
    last_name: "some last_name",
    minutes_balance: 40
  }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_user_attrs)
    user
  end

  def fixture(:visit, user) do
    create_visit_attrs = %{
      member_user_id: user.id,
      minutes: 42,
      requested_on: "2010-04-17T14:00:00Z",
      visit_date: "2010-04-17T14:00:00Z"
    }
    {:ok, visit} = Visits.create_visit(create_visit_attrs)
    visit
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all visits", %{conn: conn} do
      conn = get(conn, Routes.visit_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create visit" do
    setup [:create_user]

    test "renders errors user does not have enough minutes to request visit", %{conn: conn, user: %User{id: user_id}} do
      create_attrs = %{
        member_user_id: user_id,
        minutes: 50,
        requested_on: "2010-04-17T14:00:00Z",
        visit_date: "2010-04-17T14:00:00Z"
      }

      conn = post(conn, Routes.visit_path(conn, :create), visit: create_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders visit when data is valid", %{conn: conn, user: %User{id: user_id}} do
      create_attrs = %{
        member_user_id: user_id,
        minutes: 10,
        requested_on: "2010-04-17T14:00:00Z",
        visit_date: "2010-04-17T14:00:00Z"
      }
      conn = post(conn, Routes.visit_path(conn, :create), visit: create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.visit_path(conn, :show, id))

      assert %{
        "id" => ^id,
        "member_user_id" => ^user_id,
        "minutes" => 10,
        "requested_on" => "2010-04-17T14:00:00Z",
        "visit_date" => "2010-04-17T14:00:00Z"
      } = json_response(conn, 200)["data"]

    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.visit_path(conn, :create), visit: @invalid_visit_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
