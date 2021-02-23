defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  alias Rocketpay.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file
    |> handle_response(conn)
  end

  def simplify_string(conn, %{"string" => string}) do
    string
    |> String.trim
    |> String.downcase
    |> handle_response(conn)
  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Your number is #{result}"})
  end

  defp handle_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(reason)
  end

  defp handle_response(string, conn) do
    conn
    |> put_status(:ok)
    |> json(string)
  end
end
