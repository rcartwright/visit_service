# VisitApi

To start the server:

## If on Windows
  * install docker if not installed
  * docker-machine start
  * docker-machine env
  * docker-compose up -d - should build the image which installs elixir and runs the basic mix commands necessary for setup.
  * Create and migrate your database with `mix ecto.setup`
  * Send requests to http://192.168.99.100:4002/ (or whatever the ip that docker is on) with the /api prefix for api requests

## If on Mac
  * install docker if not installed
  * start docker through the docker UI
  * docker-compose up -d - should build the image which installs elixir and runs the basic mix commands necessary for setup.
  * Create and migrate your database with `mix ecto.setup`
  * Go to http://localhost:4002/ with the /api prefix for api requests
