defmodule Prog.Blog.PostSearchTest do
  use Prog.DataCase
  alias Prog.Blog

  setup do
    insert(:post, %{
      title: "Blue cats",
      description: "Cats are really blue",
      tags: ["elixir", "phoenix"]
    })

    insert(:post, %{
      title: "Glass city",
      description: "Towns are made of glass",
      tags: ["elixir", "nginx"]
    })

    :ok
  end

  test "search_posts/1 - searches posts by the title" do
    posts = Blog.search_posts(%{"q" => "cats"})
    assert Enum.count(posts) == 1

    posts = Blog.search_posts(%{"q" => "city"})
    assert Enum.count(posts) == 1
  end

  test "search/1 - searches posts by the description" do
    posts = Blog.search_posts(%{"q" => "really"})
    assert Enum.count(posts) == 1

    posts = Blog.search_posts(%{"q" => "towns"})
    assert Enum.count(posts) == 1
  end

  test "search/1 - performs basic stemming" do
    posts = Blog.search_posts(%{"q" => "cat"}) # The record has 'cats' in the title
    assert Enum.count(posts) == 1
  end

  test "search/1 - searches posts by the tags" do
    posts = Blog.search_posts(%{"tag" => "elixir"})
    assert Enum.count(posts) == 2

    posts = Blog.search_posts(%{"tag" => "phoenix"})
    assert Enum.count(posts) == 1

    posts = Blog.search_posts(%{"tag" => "nginx"})
    assert Enum.count(posts) == 1

    posts = Blog.search_posts(%{"tag" => "non-existing-tag"})
    assert Enum.count(posts) == 0
  end
end
