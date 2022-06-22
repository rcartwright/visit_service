defmodule VisitApiWeb.VisitController do
  use VisitApiWeb, :controller

  alias VisitApi.Visits
  alias VisitApi.Visits.Visit

  action_fallback VisitApiWeb.FallbackController

  def index(conn, _params) do
    visits = Visits.list_visits()
    render(conn, "index.json", visits: visits)
  end

  def create(conn, %{"visit" => visit_params}) do
    with {:ok, %Visit{} = visit} <- Visits.create_visit(visit_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.visit_path(conn, :show, visit))
      |> render("show.json", visit: visit)
    end
  end

  def show(conn, %{"id" => id}) do
    visit = Visits.get_visit!(id)
    render(conn, "show.json", visit: visit)
  end

  def update(conn, %{"id" => id, "visit" => visit_params}) do
    visit = Visits.get_visit!(id)

    with {:ok, %Visit{} = visit} <- Visits.update_visit(visit, visit_params) do
      render(conn, "show.json", visit: visit)
    end
  end

  def delete(conn, %{"id" => id}) do
    visit = Visits.get_visit!(id)

    with {:ok, %Visit{}} <- Visits.delete_visit(visit) do
      send_resp(conn, :no_content, "")
    end
  end
end
