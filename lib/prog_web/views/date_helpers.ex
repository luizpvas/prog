defmodule ProgWeb.DateHelpers do
  @doc """
  Formats the given date to a friendly output.

  ## Examples

      iex> date_release(~D[2019-02-19])
      "19 de fevereiro de 2019"

  """
  def date_release(date) do
    {:ok, format} = Timex.lformat(date, "{D} de {Mfull} de {YYYY}", Gettext.get_locale())
    format
  end
end