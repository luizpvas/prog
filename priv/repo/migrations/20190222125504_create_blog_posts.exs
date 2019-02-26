defmodule Prog.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string, null: false
      add :description, :text, null: false, comment: "short description of the post"
      
      add :searchable_tokens, :tsvector, comment: "The tokens for the title and description concatenated"

      add :body, :text, null: false, comment: "original markdown content"
      add :body_html, :text, null: false, comment: "compiled html from markdown"
      add :slug, :string, null: false
      add :tags, {:array, :string}, null: true
      add :published_at, :utc_datetime, null: true
      timestamps()
    end

    create index(:blog_posts, [:published_at])
    create index(:blog_posts, [:tags])
    create index(:blog_posts, [:searchable_tokens], using: :gin)
    create unique_index(:blog_posts, [:slug])
  end
end
