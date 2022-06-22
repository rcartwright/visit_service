defmodule VisitApiWeb.VisitControllerTest do
  use VisitApiWeb.ConnCase

  alias VisitApi.Visits
  alias VisitApi.Visits.Visit

  @create_attrs %{
    member_user_id: "some member_user_id",
    minutes: 42,
    requested_on: "2010-04-17T14:00:00Z",
    visit_date: "2010-04-17T14:00:00Z"
  }
  @update_attrs %{
    member_user_id: "some updated member_user_id",
    minutes: 43,
    requested_on: "2011-05-18T15:01:01Z",
    visit_date: "2011-05-18T15:01:01Z"
  }
  @invalid_attrs %{member_user_id: nil, minutes: nil, requested_on: nil, visit_date: nil}

  def fixture(:visit) do
    {:ok, visit} = Visits.create_visit(@create_attrs)
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
    test "renders visit when data is valid", %{conn: conn} do
      conn = post(conn, Routes.visit_path(conn, :create), visit: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.visit_path(conn, :show, id))

      assert %{
               "id" => id,
               "member_user_id" => "some member_user_id",
               "minutes" => 42,
               "requested_on" => "2010-04-17T14:00:00Z",
               "visit_date" => "2010-04-17T14:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.visit_path(conn, :create), visit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update visit" do
    setup [:create_visit]

    test "renders visit when data is valid", %{conn: conn, visit: %Visit{id: id} = visit} do
      conn = put(conn, Routes.visit_path(conn, :update, visit), visit: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.visit_path(conn, :show, id))

      assert %{
               "id" => id,
               "member_user_id" => "some updated member_user_id",
               "minutes" => 43,
               "requested_on" => "2011-05-18T15:01:01Z",
               "visit_date" => "2011-05-18T15:01:01Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, visit: visit} do
      conn = put(conn, Routes.visit_path(conn, :update, visit), visit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete visit" do
    setup [:create_visit]

    test "deletes chosen visit", %{conn: conn, visit: visit} do
      conn = delete(conn, Routes.visit_path(conn, :delete, visit))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.visit_path(conn, :show, visit))
      end
    end
  end

  defp create_visit(_) do
    visit = fixture(:visit)
    %{visit: visit}
  end
end
