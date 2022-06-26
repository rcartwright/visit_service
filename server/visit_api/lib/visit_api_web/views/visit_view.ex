defmodule VisitApiWeb.VisitView do
  use VisitApiWeb, :view
  alias VisitApiWeb.VisitView

  def render("index.json", %{visits: visits}) do
    %{data: render_many(visits, VisitView, "visit.json")}
  end

  def render("show.json", %{visit: visit}) do
    %{data: render_one(visit, VisitView, "visit.json")}
  end

  def render("visit.json", %{visit: visit}) do
    %{id: visit.id,
      member_user_id: visit.member_user_id,
      requested_on: visit.requested_on,
      visit_date: visit.visit_date,
      minutes: visit.minutes}
  end

  def render("422.json", _assigns) do
    %{status: 422, message: "Unprocessable entry"}
  end
end
