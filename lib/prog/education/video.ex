defmodule Prog.Education.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "education_videos" do
    field :slug
    field :title
    field :description
    field :is_public, :boolean
    field :youtube_url
    field :vimeo_url
    timestamps()
  end

  @doc """
  Builds a changeset for inserting or updating video records.

  ## Examples

      iex> Video.changeset(%Video{}, attrs)
      %Ecto.Changeset{...}

  """
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:title, :description, :is_public, :youtube_url, :vimeo_url])
    |> validate_required([:title, :description])
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
