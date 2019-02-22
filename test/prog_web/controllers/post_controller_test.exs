defmodule ProgWeb.PostControllerTest do
  use ProgWeb.ConnCase

  test "GET /posts - lists postsj", %{conn: conn} do
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
end
