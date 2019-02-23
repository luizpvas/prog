defmodule ProgWeb.NewsletterSubscriptionControllerTest do
  use ProgWeb.ConnCase
  alias Prog.Newsletter

  test "POST /newsletter_subscriptions - creates a new subscription", %{conn: conn} do
    conn = post(conn, Routes.newsletter_subscription_path(conn, :create), %{
      "email" => "luiz@example.com"
    })

    assert json_response(conn, 200)
  end

  test "POST /newsletter_subscriptions - fails to subscribe twice", %{conn: conn} do
    {:ok, _email} = Newsletter.subscribe("luiz@example.com")

    conn = post(conn, Routes.newsletter_subscription_path(conn, :create), %{
      "email" => "luiz@example.com"
    })

    assert json_response(conn, 422)
  end
end
