use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :prog, ProgWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :prog, Prog.Repo,
  username: "prog",
  password: "prog",
  database: "prog_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Map of users with admin permission.
config :prog, :admin_users, %{
  "luiz@example.com" => "1234"
}

# Configure the app's URL in order to generate
# full URLs for assets.
config :prog, :app_url, "http://localhost:4000"
