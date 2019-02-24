defmodule ProgWeb.NewsletterSubscriptionController do
  use ProgWeb, :controller
  alias Prog.Newsletter
  action_fallback ProgWeb.FallbackController

  @doc """
  GET /newsletter_subscriptions

  We need this to prevent the break of the page after posting to
  /newsletter_subscriptions
  """
  def index(conn, params) do
    render(conn, "already_subscribed.html", email: params["email"])
  end

  @doc """
  POST /newsletter_subscriptions

  Attempts to subscribe aemail new email to the newsletter.
  """
  def create(conn, params) do
    case Newsletter.subscribe(params["email"]) do
      {:ok, _email} ->
        render(conn, "success.html", email: params["email"])

      {:error, _changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("already_subscribed.html", email: params["email"])
    end
  end
end
