defmodule Prog.Repo.Migrations.CreateEducationVideos do
  use Ecto.Migration

  def change do
    create table(:education_videos) do
      add :slug, :string
      add :title, :string
      add :description, :text
      add :is_public, :boolean, default: true
      add :youtube_url, :string, null: true
      add :vimeo_url, :string, null: true
      timestamps()
    end

    create unique_index(:education_videos, [:slug])
  end
end
