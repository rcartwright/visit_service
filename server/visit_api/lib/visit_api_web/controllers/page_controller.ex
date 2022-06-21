defmodule VisitApiWeb.PageController do
  use VisitApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
