defmodule ProgWeb.ImageControllerTest do
  use ProgWeb.ConnCase

  test "POST /images - uploads an file", %{conn: conn} do
    conn = 
      conn
      |> login_admin()
      |> post(Routes.image_path(conn, :create), %{
        "file" => fixture_file()
      })

    assert json_response(conn, 200)
  end

  test "POST /images - denies if user is not admin", %{conn: conn} do
    assert_error_sent :forbidden, fn ->
      post(conn, Routes.image_path(conn, :create), %{
        "file" => fixture_file()
      })
    end
  end

  defp fixture_file do
    %Plug.Upload{
      path: "test/fixtures/example.png",
      filename: "example.png"
    }
  end
end
