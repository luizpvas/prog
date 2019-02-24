defmodule ProgWeb.PostControllerTest do
  use ProgWeb.ConnCase
  alias Prog.Blog

  test "GET /posts - lists posts", %{conn: conn} do
    posts = insert_list(3, :post)

    conn = get(conn, Routes.post_path(conn, :index))

    assert html_response(conn, 200) =~ Enum.at(posts, 0).title
    assert html_response(conn, 200) =~ Enum.at(posts, 1).title
    assert html_response(conn, 200) =~ Enum.at(posts, 2).title
  end

  test "GET /posts/:slug - shows a post", %{conn: conn} do
    post = insert(:post)

    conn = get(conn, Routes.post_path(conn, :show, post.slug))

    assert html_response(conn, 200)
  end
  
  test "GET /posts/:slug - shows 404", %{conn: conn} do
    conn = get(conn, Routes.post_path(conn, :show, "wrong-slug"))
    assert html_response(conn, 404)
  end

  test "GET /posts/new - shows the create post form", %{conn: conn} do
    conn =
      conn
      |> login_admin()
      |> get(Routes.post_path(conn, :new))

    assert html_response(conn, 200)
  end

  test "POST /posts - creates a new post if attributes are valid", %{conn: conn} do
    conn =
      conn
      |> login_admin()
      |> post(Routes.post_path(conn, :create, %{
        "post" => %{
          "title" => "Interesting post",
          "description" => "A cool description",
          "body" => "This is definetly interesting",
          "published_at" => "2019-08-30",
          "tags" => "elixir, phoenix"
        }
      }))

    assert html_response(conn, 302)
    assert {:ok, blog} = Blog.find_post_by_slug("interesting-post")
    assert blog.tags == ["elixir", "phoenix"]
  end

  test "POST /posts - shows validation errors if attributes are invalid", %{conn: conn} do
    conn =
      conn
      |> login_admin()
      |> post(Routes.post_path(conn, :create, %{
        "post" => %{
          "title" => "",
          "description" => "",
          "body"  => ""
        }
      }))

    assert html_response(conn, 200)
    assert Blog.count_posts() == 0
  end

  test "GET /posts/:id/edit - renders the edit form", %{conn: conn} do
    post = insert(:post)

    conn = 
      conn
      |> login_admin()
      |> get(Routes.post_path(conn, :edit, post.slug))

    assert html_response(conn, 200)
  end

  test "PUT /posts/:id - updates the post record", %{conn: conn} do
    post = insert(:post)

    conn = 
      conn
      |> login_admin()
      |> put(Routes.post_path(conn, :update, post.slug), %{
        "post" => %{
          "title" => "My updated title"
        }
      })

    assert redirected_to(conn) == Routes.post_path(conn, :show, "my-updated-title")
  end
end
