defmodule ProgWeb.FallbackController do
  use ProgWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ProgWeb.ChangesetView)
    |> render("errors.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ProgWeb.ErrorView)
    |> render("404.html")
  end
end
