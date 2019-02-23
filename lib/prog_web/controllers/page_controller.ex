defmodule ProgWeb.PageController do
  use ProgWeb, :controller

  def index(conn, _params) do
    posts = Prog.Blog.list_latest_published_posts(5)
    render(conn, "index.html", posts: posts)
  end
end
