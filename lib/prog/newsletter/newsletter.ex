defmodule Prog.Newsletter do
  alias Prog.Newsletter.Email
  alias Prog.Repo

  @doc """
  Attempts to create a new email subscription to the newsletter.

  ## Examples

      iex> Newsletter.subscribe("luiz@example.com")
      {:ok, %Email{...}}

      iex> Newsletter.subscribe("already_exists@exemple.com")
      {:error, %Ecto.Changeset{...}}

  """
  def subscribe(email) do
    Email.changeset(%Email{}, %{"email" => email})
    |> Repo.insert()
  end
end
