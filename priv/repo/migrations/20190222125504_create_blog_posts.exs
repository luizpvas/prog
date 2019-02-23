defmodule Prog.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string
      add :body, :text, comment: "original markdown content"
      add :body_html, :text, comment: "compiled html from markdown"
      add :slug, :string
      add :tags, {:array, :string}
      add :published_at, :utc_datetime, null: true
      timestamps()
    end

    create index(:blog_posts, [:published_at])
    create index(:blog_posts, [:tags])
    create unique_index(:blog_posts, [:slug])
  end
end
