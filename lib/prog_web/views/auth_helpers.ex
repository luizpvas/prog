defmodule ProgWeb.AuthHelpers do
  def logged_in?(conn) do
    Plug.Conn.get_session(conn, :user_email)
  end

  def admin?(conn) do
    conn
    |> current_user_email()
    |> Prog.Accounts.admin?()
  end

  def current_user_email(conn) do
    Plug.Conn.get_session(conn, :user_email)
  end
end
