defmodule ProgWeb.ChangesetView do
  use ProgWeb, :view

  def render("errors.json", %{changeset: changeset}) do
    Enum.map(changeset.errors, fn {key, {msg, _details}} ->
      {key, msg}
    end)
    |> Enum.into(%{})
  end
end
