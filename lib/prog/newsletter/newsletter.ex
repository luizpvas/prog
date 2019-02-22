defmodule Prog.Newsletter do
  alias Prog.Newsletter.Email
  alias Prog.Repo

  def create_email(attributes) do
    Email.changeset(%Email{}, attributes)
    |> Repo.insert()
  end
end