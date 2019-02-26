defmodule Prog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blog_posts" do
    field :title, :string
    field :description, :string
    field :body, :string
    field :body_html, :string
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
    |> cast(attrs, [:title, :description, :body, :published_at, :tags])
    |> validate_required([:title, :description, :body])
    |> generate_slug_from_title()
    |> unique_constraint(:slug)
    |> compile_markdown()
    |> copy_title_and_description_vectors()
  end

  # Copies adn title and description to the indexed tsvector
  # columns in order to perform search.
  defp copy_title_and_description_vectors(%{valid?: false} = changeset), do: changeset
  defp copy_title_and_description_vectors(changeset) do
    title = get_field(changeset, :title)
    description = get_field(changeset, :description)
    
    changeset
    |> put_change(:title_tokens, title)
    |> put_change(:description_tokens, description)
  end

  # Generates the slug for the video based on the title.
  # I could pull a library for this, but 
  defp generate_slug_from_title(%{valid?: false} = changeset), do: changeset
  defp generate_slug_from_title(changeset) do
    title = get_field(changeset, :title)
    put_change(changeset, :slug, Prog.Slug.to_slug(title))
  end

  # Compiles the body that is expected to be markdown to HTML.
  defp compile_markdown(%{valid?: false} = changeset), do: changeset
  defp compile_markdown(changeset) do
    put_change(
      changeset,
      :body_html,
      Earmark.as_html!(get_field(changeset, :body))
    )
  end
end
