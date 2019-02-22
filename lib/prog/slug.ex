defmodule Prog.Slug do
  def to_slug(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[?,\/\(\)\[\]\'\"-]/, " ")
    |> String.replace(~r/[\s]{2,}/, " ")
    |> String.trim()
    |> String.replace(" ", "-")
  end
end