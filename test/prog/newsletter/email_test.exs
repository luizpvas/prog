defmodule Prog.Newsletter.EmailTest do
  use Prog.DataCase
  alias Prog.Newsletter

  test "create_email - validates uniqueness of email" do
    {:ok, _email} = Newsletter.create_email(%{
      "email" => "luiz@exemplo.com"
    })

    {:error, changeset} = Newsletter.create_email(%{
      "email" => "luiz@exemplo.com"
    })

    assert changeset.errors[:email]
  end
end
