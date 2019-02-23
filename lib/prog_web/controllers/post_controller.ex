defmodule ProgWeb.PostController do
  use ProgWeb, :controller
  alias Prog.Blog
  action_fallback(ProgWeb.FallbackController)

  @doc """
  GET /posts

  Lists all available posts on the database.
  """
  def index(conn, _params) do
    posts = Blog.list_latest_published_posts(500)
    render(conn, "index.html", posts: posts)
  end

  @doc """
  GET /posts/new

  Shows the create post form.
  """
  def new(conn, _params) do
    render(conn, "new.html", changeset: Blog.post_changeset())
  end

  @doc """
  POST /posts

  Attempts to create a new post.
  """
  def create(conn, params) do
    case Blog.create_post(params) do
      {:ok, _post} ->
        redirect(conn, to: Routes.post_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @doc """
  GET /posts/:slug

  Shows the video page.
  """
  def show(conn, params) do
    with {:ok, post} <- Prog.Blog.find_post_by_slug(params["id"]) do
      render(conn, "show.html", post: post)
    end
  end
end
