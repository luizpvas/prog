defmodule ProgWeb.ImageController do
  use ProgWeb, :controller

  @doc """
  POST /images

  Uploads an image and store in the filesystem.
  """
  def create(conn, params) do
    authorize_admin!(conn)

    if file = params["file"] do
      path = "/uploads/" <> file.filename

      File.cp(file.path, Application.app_dir(:prog, "priv") <> "/static" <>  path)

      json(conn, %{
        "url" => Application.get_env(:prog, :app_url) <> path
      })
    end
  end
end
