defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Test User",
        password: "123456",
        nickname: "testuser",
        email: "test@email.com",
        age: 21
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{
        name: "Test User",
        age: 21,
        id: ^user_id
      } = user
    end

    test "when params are invalid, returns an error" do
      params = %{
        name: "Test User",
        nickname: "testuser",
        email: "test@email.com",
        age: 0
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert expected_response == errors_on(changeset)
    end
  end
end
