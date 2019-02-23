defmodule ProgWeb.AuthorizationHelpers do
  def authorize_admin!(conn) do
    user_email = Plug.Conn.get_session(conn, :user_email)
    unless Prog.Accounts.admin?(user_email) do
      raise ProgWeb.NotAuthorized
    end
  end
end
