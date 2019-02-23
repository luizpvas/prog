defmodule ProgWeb.SessionControllerTest do
  use ProgWeb.ConnCase

  test "POST /sessions - logs in if credentials match", %{conn: conn} do
    conn = post(conn, Routes.session_path(conn, :create), %{
      "email" => "luiz@example.com",
      "password" => "1234"
    })

    assert get_session(conn, :user_email) == "luiz@example.com"
    assert redirected_to(conn) == "/"
  end

  test "POST /sessions - doesn't log in if credentials are wrong", %{conn: conn} do
    conn = post(conn, Routes.session_path(conn, :create), %{
      "email" => "luiz@example.com",
      "password" => "wrong-password"
    })

    assert html_response(conn, 200)
    assert get_session(conn, :user_email) == nil
  end
end
