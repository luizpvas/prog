defmodule Prog.Newsletter.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "newsletter_emails" do
    field :email, :string
    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
