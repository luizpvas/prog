defmodule Prog.Blog.PostQueries do
  alias Prog.Repo
  alias Prog.Blog.Post
  import Ecto.Query

  def search(params) do
    query = Post |> is_published() |> limit(^20)

    Enum.reduce(params, query, &filter/2)
    |> Repo.all()
  end

  @doc """
  Filters out posts that are not published yet.
  """
  def is_published(query) do
    where(query, [p], not is_nil(p.published_at))
  end

  @doc """
  Sorts the results from newest to oldest.
  """
  def latest(query) do
    order_by(query, [desc: :id])
  end

  defp filter({"q", q}, query) do
    query
    |> where(fragment("searchable_tokens @@ to_tsquery(?)", ^format_tsquery(q)))
    |> order_by(fragment("ts_rank_cd(searchable_tokens, to_tsquery(?))", ^format_tsquery(q)))
  end

  defp filter({"tag", tag}, query) do
    where(query, fragment("?=ANY(tags)", ^tag))
  end

  # Catch-all for filters we do not support
  defp filter({_, _}, query), do: query

  defp format_tsquery(query) do
    query
    |> String.split(" ")
    |> Enum.map(&String.trim/1)
    |> Enum.join(" | ")
  end
end
