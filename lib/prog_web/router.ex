defmodule ProgWeb.Router do
  use ProgWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ProgWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/posts", PostController, :index
    get "/posts/:slug", PostController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ProgWeb do
  #   pipe_through :api
  # end
end
