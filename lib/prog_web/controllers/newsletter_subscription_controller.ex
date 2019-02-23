defmodule ProgWeb.NewsletterSubscriptionController do
  use ProgWeb, :controller
  alias Prog.Newsletter
  action_fallback ProgWeb.FallbackController

  @doc """
  POST /newsletter_subscriptions

  Attempts to subscribe aemail new email to the newsletter.
  """
  def create(conn, params) do
    with {:ok, email} <- Newsletter.subscribe(params["email"]) do
      json(conn, %{
        id: email.id,
        email: email.email
      })
    end
  end
end
