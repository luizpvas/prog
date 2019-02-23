defmodule Prog.AccountsTest do
  use Prog.DataCase
  alias Prog.Accounts

  test "authenticate/2 - finds the user if credentials match" do
    {:ok, user} = Accounts.authenticate("luiz@example.com", "1234")
    assert user[:email] == "luiz@example.com"
  end

  test "authenticate/2 - doesn't authenticate if credentials are wrong" do
    assert {:error, :invalid_credentials} = 
      Accounts.authenticate("luiz@example.com", "wrong-password")
  end

  test "admin?/1 - checks if a user is an admin" do
    assert Accounts.admin?("luiz@example.com")
    refute Accounts.admin?("another@example.com")
  end
end
