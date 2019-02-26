defmodule Prog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Prog.Repo,

      # Start the endpoint when the application starts
      ProgWeb.Endpoint,

      # Starts a worker by calling: Prog.Worker.start_link(arg)
      {ConCache, [name: :prog_cache, ttl_check_interval: :timer.seconds(5), global_ttl: :timer.seconds(60)]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Prog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ProgWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
