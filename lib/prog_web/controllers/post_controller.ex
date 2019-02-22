defmodule ProgWeb.PostController do
  use ProgWeb, :controller

  @doc """
  GET /posts

  Lists all available posts on the database.
  """
  def index(conn, _params) do
    posts = Prog.Blog.list_latest_posts(500)
    render(conn, "index.html", posts: posts)
  end

  @doc """
  GET /posts/:slug

  Shows the video page.
  """
  def show(conn, params) do
    with {:ok, post} <- Prog.Blog.find_post_by_slug(params["slug"]) do
      render(conn, "show.html", post: post)
    end
  end
end
