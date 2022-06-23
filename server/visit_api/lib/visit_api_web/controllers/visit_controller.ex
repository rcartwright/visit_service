defmodule VisitApiWeb.VisitController do
  use VisitApiWeb, :controller

  alias VisitApi.Visits
  alias VisitApi.Visits.Visit
  alias VisitApi.Accounts
  alias VisitApi.Accounts.User

  action_fallback VisitApiWeb.FallbackController

  def index(conn, _params) do
    visits = Visits.list_visits()
    render(conn, "index.json", visits: visits)
  end

  @doc """
  Sample request body for create
  {
    "visit": {
        "member_user_id": "some member_user_id",
        "minutes": 43,
        "requested_on": "2011-05-18T15:01:01Z",
        "visit_date": "2011-05-18T15:01:01Z"
    }
  }
  """

  # change this to be called request_visit instead in the future to be more specific
  def create(conn, %{
    "visit" => %{
      "member_user_id" => uid,
      "minutes" => minutes
    }
  } = visit_params) do
    #  in the future - change this to pass in a bearer token in header instead
    user = Accounts.get_user!(uid)
   # IO.inspect("minutes > user.minutes_balance", minutes > user.minutes_balance)
    case minutes > user.minutes_balance do
      true ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json",  user: user)

      _ ->
        with {:ok, %Visit{id: id} = visit} <- Visits.create_visit(visit_params) do
          visit = Visits.get_visit!(id)

        #  IO.inspect("the created visit", visit)

          conn
          # check to make sure user has enough minutes left & that user doesn't already have anything already submitted for that day
          |> put_status(:created)
          |> put_resp_header("location", Routes.visit_path(conn, :show, visit))
          |> render("show.json", visit: visit)
        end
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
