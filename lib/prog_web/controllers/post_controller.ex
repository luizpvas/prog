defmodule ProgWeb.PostController do
  use ProgWeb, :controller
  alias Prog.Blog
  action_fallback ProgWeb.FallbackController

  @doc """
  GET /posts

  Lists all available posts on the database.
  """
  def index(conn, params) do
    # Can I make this check shorter?
    has_filters? = 
      (params["q"] && params["q"] != "") ||
        (params["tag"] && params["tag"] != "")

    posts =
      if has_filters? do
        Blog.search_posts(params)
      else
        Blog.list_latest_published_posts(500)
      end

    render(conn, "index.html", posts: posts)
  end

  @doc """
  GET /posts/new

  Shows the create post form.
  """
  def new(conn, _params) do
    authorize_admin!(conn)

    render(conn, "new.html", changeset: Blog.post_changeset())
  end

  @doc """
  POST /posts

  Attempts to create a new post.
  """
  def create(conn, params) do
    authorize_admin!(conn)

    case Blog.create_post(fix_post_params(params["post"])) do
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

  @doc """
  GET /posts/:slug/edit

  Renders the edit form.
  """
  def edit(conn, params) do
    authorize_admin!(conn)

    with {:ok, post} <- Prog.Blog.find_post_by_slug(params["id"]) do
      render(
        conn, 
        "edit.html", 
        post: post,
        changeset: Blog.post_changeset(post)
      )
    end
  end

  @doc """
  PUT /posts/:slug

  Attempts to update a post.
  """
  def update(conn, params) do
    with {:ok, post} <- Blog.find_post_by_slug(params["id"]) do
      case Blog.update_post(post, fix_post_params(params["post"])) do
        {:ok, post} ->
          conn
          |> put_flash(:success, gettext("Post atualizado com sucesso!"))
          |> redirect(to: Routes.post_path(conn, :show, post.slug))

        {:error, changeset} ->
          conn
          |> render("edit.html", changeset: changeset, post: post)
      end
    end
  end

  defp fix_post_params(params) do
    params
    |> fix_published_at()
    |> fix_tags()
  end

  # Appends the time part in the given published_at params.
  # All posts are assumed to be posted 12:00:00
  defp fix_published_at(%{"published_at" => published_at} = params) do
    Map.put(params, "published_at", published_at <> " 12:00:00")
  end
  defp fix_published_at(params), do: params

  # Splits the tags into an array of strings.
  defp fix_tags(%{"tags" => tags} = params) do
    tags = String.split(tags, ",") |> Enum.map(&String.trim/1)
    Map.put(params, "tags", tags)
  end
  defp fix_tags(params), do: params
end
