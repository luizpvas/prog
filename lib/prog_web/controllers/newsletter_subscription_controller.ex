defmodule ProgWeb.NewsletterSubscriptionController do
  use ProgWeb, :controller
  alias Prog.Newsletter
  action_fallback ProgWeb.FallbackController

  @doc """
  POST /newsletter_subscriptions

  Attempts to subscribe aemail new email to the newsletter.
  """
  def create(conn, params) do
    case Newsletter.subscribe(params["email"]) do
      {:ok, email} ->
        render(conn, "success.html", email: params["email"])

      {:error, _changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("already_subscribed.html", email: params["email"])
    end
  end
end
