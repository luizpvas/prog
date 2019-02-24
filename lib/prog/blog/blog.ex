defmodule Prog.Blog do
  alias Prog.Blog.Post
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
    Post
    |> where([p], not is_nil(p.published_at))
    |> order_by([p], [desc: :id])
    |> limit([p], ^limit)
    |> Repo.all()
  end

  def find_post_by_slug(slug) do
    case Repo.get_by(Post, slug: slug) do
      nil -> {:error, :not_found}
      post -> {:ok, post}
    end
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
