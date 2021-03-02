defmodule RocketpayWeb.UserViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias RocketpayWeb.UserView
  alias Rocketpay.{Account, User}

  test "renders create.json" do
    params = %{
      name: "Test User",
      password: "123456",
      nickname: "testuser",
      email: "test@email.com",
      age: 21
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      Rocketpay.create_user(params)

    response = render(UserView, "create.json", user: user)

    expected_result = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.0"),
          id: account_id
          },
        id: user_id,
        name: "Test User",
        nickname: "testuser"}
      }

    assert expected_result == response
  end
end
