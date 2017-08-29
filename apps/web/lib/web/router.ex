defmodule Web.Router do
  use Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Web.Locale
  end

  scope "/", Web do
    pipe_through :browser # Use the default browser stack

    get "/", OpportunitiesController, :index
  end

  scope "/webhooks", Web do
    pipe_through :api

    post "/github", GitHubWebhookController, :create
  end
end
