defmodule ProgWeb.NotAuthorized do
  defexception [message: "You do not have access to this page.", plug_status: 403]
end
