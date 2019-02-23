defmodule Prog.Accounts do
  @doc """
  Attempts to authenticate an admin user.

  ## Examples

      iex> Accounts.authenticate("luiz@example.com", "1234")
      {:ok, %{email: "luiz@example.com"}}

      iex> Accounts.authenticate("luiz@example.com", "wrong")
      {:error, "invalid credentials"}

  """
  def authenticate(email, password) do
    users = Application.get_env(:prog, :admin_users)

    if users[email] == password do
      {:ok, %{email: email}}
    else
      {:error, :invalid_credentials}
    end
  end

  @doc """
  Checks if the given user email is from an admin.

  ## Examples

      iex> Accounts.admin?("luiz@example.com")
      true

  """
  def admin?(user_email) do
    users = Application.get_env(:prog, :admin_users)
    Map.has_key?(users, user_email)
  end
end
