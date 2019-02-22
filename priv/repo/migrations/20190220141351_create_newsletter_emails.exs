defmodule Prog.Repo.Migrations.CreateNewsletterEmails do
  use Ecto.Migration

  def change do
    create table(:newsletter_emails) do
      add :email, :string
      timestamps()
    end

    create unique_index(:newsletter_emails, [:email])
  end
end
