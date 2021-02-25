defmodule RocketpayWeb.UserController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  action_fallback(RocketpayWeb.FallbackController)

  def index(conn, params) do
    with {:ok, %User{} = user} <-
           Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
