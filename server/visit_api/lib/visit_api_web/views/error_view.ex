defmodule VisitApiWeb.ErrorView do
  use VisitApiWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  def render("422.json", _assigns) do
    %{status: 422, message: "Unprocessable entry"}
  end

  def render("500.json", _assigns) do
    %{status: 500, message: "Internal Server Error"}
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
