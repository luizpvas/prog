defmodule Prog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blog_posts" do
    field :body, :string
    field :title, :string
    field :slug, :string
    field :published_at, :utc_datetime
    field :tags, {:array, :string}
    timestamps()
  end

  @doc """
  Builds a changeset for inserting or updating a blog post.

  ## Example
  
      iex> Post.changeset(%Post{}, attributes)
      %Ecto.Changeset{...}

  """
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :published_at, :tags])
    |> validate_required([:title, :body])
    |> generate_slug_from_title()
    |> unique_constraint(:slug)
  end

  # Generates the slug for the video based on the title.
  # I could pull a library for this, but 
  defp generate_slug_from_title(%{valid?: false} = changeset), do: changeset
  defp generate_slug_from_title(changeset) do
    title = get_field(changeset, :title)
    put_change(changeset, :slug, Prog.Slug.to_slug(title))
  end
end
