defmodule Prog.Blog do
  alias Prog.Blog.{Post, PostQueries}
  alias Prog.Repo
  import Ecto.Query

  def create_post(attributes) do
    Post.changeset(%Post{}, attributes)
    |> Repo.insert()
  end

  def update_post(post, attributes) do
    Post.changeset(post, attributes)
    |> Repo.update()
  end

  @doc """
  Fetches the latest published posts from most recent to oldest.

  ## Examples

      iex> Blog.list_latest_published_posts(3)
      [%Post{...}, %Post{...}, %Post{...}]

  """
  def list_latest_published_posts(limit) do
    Prog.Cache.get_or_store("latest_posts_#{limit}", fn ->
      Post
      |> PostQueries.is_published()
      |> PostQueries.latest()
      |> limit([p], ^limit)
      |> Repo.all()
    end)
  end

  @doc """
  Searches for posts based on the given criteria.

  ## Supported filters

    * "q" - Applied to title and description using Postgre's fulltext search.
    * "tag" - Applied to the tags list.

  ## Examples

      iex> Blog.search_posts(%{"q" => "Gzip"})
      [%Post{...}, %Post{...}]

  """
  def search_posts(criteria) do
    PostQueries.search(criteria)
  end

  @doc """
  Attempts to find a post by the given slug.

  ## Examples
  
      iex> Blog.find_post_by_slug("existing-post")
      {:ok, %Post{...}}

      iex> Blog.find_post_by_slug("invalid-slug")
      {:error, :not_found}

  """
  def find_post_by_slug(slug) do
    Prog.Cache.get_or_store("post/" <> slug, fn ->
      case Repo.get_by(Post, slug: slug) do
        nil -> {:error, :not_found}
        post -> {:ok, post}
      end
    end)
  end

  @doc """
  Counts the amount of posts in the database.

  ## Example
  
      iex> Blog.count_posts()
      6

  """
  def count_posts() do
    Repo.one(from p in Post, select: count(p))
  end

  @doc """
  Returns a changeset for the given post, or a new post
  if none is given. This is used to render forms in the front-end.

  ## Examples
  
      iex> Blog.post_changeset()
      %Ecto.Changeset{...}

  """
  def post_changeset(post \\ %Post{}) do
    Post.changeset(post, %{})
  end
end
