# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :visit_api,
  ecto_repos: [VisitApi.Repo]

# Configures the endpoint
config :visit_api, VisitApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vMl3+TYUMOEbkx4eLCg8WY2aq4PJa9CPC0Lrzvpzh9GJkLsoL6Z1M+sdxGAwH5Fs",
  render_errors: [view: VisitApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: VisitApi.PubSub,
  live_view: [signing_salt: "7WhUyur4"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
