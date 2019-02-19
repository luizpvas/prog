defmodule ProgWeb.PageController do
  use ProgWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
