defmodule ProgWeb.TagHelpers do
  use Phoenix.HTML

  def allowed_tags, do: ["elixir", "phoenix", "js", "webpack", "nginx"]

  def post_tags(nil), do: ""
  def post_tags(tags) do
    Enum.map(tags, fn tag ->
      content_tag :div, tag, class: "text-sm uppercase text-white rounded px-1 font-bold mr-1 #{tag_class_background(tag)}"
    end)
  end

  def tags_input_value(nil), do: ""
  def tags_input_value(tags), do: Enum.join(tags, ", ")

  defp tag_class_background("elixir"), do: "bg-indigo"
  defp tag_class_background("phoenix"), do: "bg-orange"
  defp tag_class_background("javascript"), do: "bg-yellow-dark"
  defp tag_class_background(_), do: "bg-grey-dark"
end
