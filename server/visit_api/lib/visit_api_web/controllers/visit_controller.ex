defmodule VisitApiWeb.VisitController do
  use VisitApiWeb, :controller

  alias VisitApi.Visits
  alias VisitApi.Visits.Visit

  action_fallback VisitApiWeb.FallbackController

  def index(conn, _params) do
    visits = Visits.list_visits()
    render(conn, "index.json", visits: visits)
  end

  @doc """
  This is used for members to request a visit.
  Sample request body:
  {
    "visit": {
        "member_user_id": "a uuid",
        "minutes": 43,
        "requested_on": "2011-05-18T15:01:01Z",
        "visit_date": "2011-05-18T15:01:01Z"
    }
  }
  """
  # perhaps change this to be called request_visit instead in the future to be more specific
  def create(conn, %{"visit" => visit_params}) do

    with {:ok, visit} <- Visits.create_visit(visit_params) do

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
