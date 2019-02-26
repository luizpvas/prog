defmodule Prog.Repo.Migrations.CreateBlogPostsTriggers do
  use Ecto.Migration

  def up do
    execute("""
      CREATE OR REPLACE FUNCTION blog_post_populate_tsvectors()
      RETURNs trigger AS
      $BODY$
      BEGIN
        NEW.searchable_tokens = (to_tsvector(NEW.title) || to_tsvector(NEW.description));
        RETURN NEW;
      END;
      $BODY$ LANGUAGE plpgsql;
    """)

    execute("""
      CREATE TRIGGER blog_post_before_update
      BEFORE UPDATE
      ON blog_posts
      FOR EACH ROW
      EXECUTE PROCEDURE blog_post_populate_tsvectors();
    """)

    execute("""
      CREATE TRIGGER blog_post_before_insert
      BEFORE INSERT
      ON blog_posts
      FOR EACH ROW
      EXECUTE PROCEDURE blog_post_populate_tsvectors();
    """)
  end
end
