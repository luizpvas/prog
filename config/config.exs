# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :prog,
  ecto_repos: [Prog.Repo]

# Configures the endpoint
config :prog, ProgWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yRZi811kxcjggzmo/c4YqU8J4C7phqbCq7hJYT2kVrUuK0nfGejbeXSWR44AgN6P",
  render_errors: [view: ProgWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Prog.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
