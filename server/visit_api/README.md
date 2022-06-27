# VisitApi

To start the server:

## To start server with Docker

### If on Windows
  * Install docker if not installed
  * Run `docker-machine start`
  * Run `docker-machine env`
  * Run `docker-compose up -d` - should build the image which installs elixir and runs the basic mix commands necessary for setup.
  * Create and migrate your database with `docker-compose run app_container mix ecto.setup`
  * Send requests to http://192.168.99.100:4002/ (or whatever the ip that docker is on) with the /api prefix for api requests

### If on Mac (haven't tested it)
  * Install docker if not installed
  * Start docker through the docker UI
  * Run `docker-compose up -d` - should build the image which installs elixir and runs the basic mix commands necessary for setup.
  * Create and migrate your database with `docker-compose run app_container mix ecto.setup`
  * Go to http://localhost:4002/ with the /api prefix for api requests

## To Start server without Docker
  * Install Elixir if not installed
  * Go into the directory where the mix.exs file is by typing `cd server/visit_api` into the terminal 
  * Install these dependencies by running `mix local.hex && mix local.rebar && mix archive.install hex phx_new 1.5.7` - may need to add `--force` at the end of them
  * Install the rest of dependencies with mix deps.get
  * Create and migrate your database with mix ecto.setup
  * Start Phoenix endpoint with mix phx.server

## To run tests,
 * Run `mix test` or if on a docker container `docker-compose run app_container mix test`