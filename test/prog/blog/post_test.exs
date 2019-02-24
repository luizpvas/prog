defmodule Prog.Blog.PostTest do
  use Prog.DataCase
  alias Prog.Blog

  test "create_post/1 - creates a record with valid attrs" do
    {:ok, video} = Blog.create_post(%{
      "title" => "My first video",
      "description" => "This is a description",
      "body"  => "This is an interesting video",
      "tags"  => ["elixir", "phoenix"]
    })

    assert video.id
    assert video.title == "My first video"
    assert video.slug  == "my-first-video"
    assert video.body  == "This is an interesting video"
    assert video.tags  == ["elixir", "phoenix"]
  end

  test "create_post/1 - validates title and body" do
    {:error, changeset} = Blog.create_post(%{
      "title" => "",
      "body"  => "",
    })

    assert changeset.errors[:title]
    assert changeset.errors[:body]
  end

  test "create_post/1 - validates slug is unique" do
    {:ok, _post} = Blog.create_post(%{
      "title" => "My first video",
      "description" => "This is a description",
      "body"  => "This is a description"
    })

    {:error, changeset} = Blog.create_post(%{
      "title" => "My first video",
      "description" => "This is a description",
      "body"  => "This is a description"
    })

    assert changeset.errors[:slug]
  end

  test "create_post/1 - compiles markdown to html" do
    {:ok, post} = Blog.create_post(%{
      "title" => "My first post",
      "description" => "This is a description",
      "body" => "This is *nice*"
    })

    assert post.body_html == "<p>This is <em>nice</em></p>\n"
  end

  test "list_latest_published_posts/1 - lists the latest posts in the database" do
    posts = insert_list(10, :post)
    latest_posts = Blog.list_latest_published_posts(5)

    posts_ids = posts |> Enum.reverse() |> Enum.map(& &1.id) |> Enum.slice(0..4)
    latest_posts_ids = Enum.map(latest_posts, & &1.id)
    
    assert posts_ids == latest_posts_ids
  end

  test "find_post_by_slug/1 - finds a post by slug" do
    post = insert(:post)

    assert {:ok, found_post} = Blog.find_post_by_slug(post.slug)

    assert found_post.id == post.id
  end

  test "find_post_by_slug/1 - returns not_found if post doesnt exist" do
    assert {:error, :not_found} == Blog.find_post_by_slug("wrong-slug")
  end
end
