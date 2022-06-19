defmodule Visit.Repo do
  use Ecto.Repo,
    otp_app: :visit,
    adapter: Ecto.Adapters.Postgres
end
