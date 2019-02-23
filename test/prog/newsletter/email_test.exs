defmodule Prog.Newsletter.EmailTest do
  use Prog.DataCase
  alias Prog.Newsletter

  test "subscribe/1 - validates uniqueness of email" do
    {:ok, _email} = Newsletter.subscribe("luiz@exemple.com")
    {:error, changeset} = Newsletter.subscribe("luiz@exemple.com")

    assert changeset.errors[:email]
  end
end
