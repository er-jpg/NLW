defmodule RocketpayWeb.Router do
  use RocketpayWeb, :router

  import Plug.BasicAuth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug :basic_auth, Application.compile_env(:rocket_pay, :basic_auth)
  end

  scope "/api", RocketpayWeb do
    pipe_through :api

    get "/:filename", WelcomeController, :index
    post "/users", UserController, :create

    get "/string/:string", WelcomeController, :simplify_string

    # post "/accounts/:id/deposit", AccountController, :deposit
    # post "/accounts/:id/withdraw", AccountController, :withdraw
    # post "/accounts/transaction", AccountController, :transaction
  end

  scope "/api", RocketpayWeb do
    # Auth error with params ????????
    # pipe_through [:api, :auth]
    pipe_through :api

    post "/accounts/:id/deposit", AccountController, :deposit
    post "/accounts/:id/withdraw", AccountController, :withdraw
    post "/accounts/transaction", AccountController, :transaction
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RocketpayWeb.Telemetry
    end
  end
end
