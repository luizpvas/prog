defmodule ProgWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias ProgWeb.Router.Helpers, as: Routes
      import Prog.Factory

      # The default endpoint for testing
      @endpoint ProgWeb.Endpoint

      def login_admin(conn) do
        post(conn, Routes.session_path(conn, :create), %{
          "email" => "luiz@example.com",
          "password" => "1234"
        })
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Prog.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Prog.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
