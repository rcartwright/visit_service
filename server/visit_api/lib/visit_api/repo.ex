defmodule VisitApi.Repo do
  use Ecto.Repo,
    otp_app: :visit_api,
    adapter: Ecto.Adapters.Postgres
end
