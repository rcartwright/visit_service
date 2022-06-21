defmodule VisitApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      VisitApi.Repo,
      # Start the Telemetry supervisor
      VisitApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: VisitApi.PubSub},
      # Start the Endpoint (http/https)
      VisitApiWeb.Endpoint
      # Start a worker by calling: VisitApi.Worker.start_link(arg)
      # {VisitApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VisitApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    VisitApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
