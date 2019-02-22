defmodule Prog.Blog do
  alias Prog.Blog.Post
  alias Prog.Repo
  import Ecto.Query

  def create_post(attributes) do
    Post.changeset(%Post{}, attributes)
    |> Repo.insert()
  end

  def list_latest_posts(limit) do
    query = from p in Post, order_by: [desc: :id], limit: ^limit
    Repo.all(query)
  end

  def find_post_by_slug(slug) do
    case Repo.get_by(Post, slug: slug) do
      nil -> {:error, :not_found}
      post -> {:ok, post}
    end
  end
end
