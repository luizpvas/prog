defmodule ProgWeb.SessionController do
  use ProgWeb, :controller
  alias Prog.Accounts
  action_fallback ProgWeb.FallbackController

  @doc """
  GET /sessions/new

  Renders the login form.
  """
  def new(conn, _params) do
    render(conn, "new.html")
  end

  @doc """
  POST /sessions

  Attempts to login using the given credentials "email" and "password".
  """
  def create(conn, params) do
    case Accounts.authenticate(params["email"], params["password"]) do
      {:ok, user} ->
        conn
        |> put_session(:user_email, user[:email])
        |> redirect(to: "/")

      {:error, :invalid_credentials} ->
        conn
        |> render("new.html")
    end
  end
end
