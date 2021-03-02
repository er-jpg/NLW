defmodule Rocketpay.Accounts.Deposit do
  alias Rocketpay.{Accounts.Operation, Repo}

  def call(params) do
    IO.inspect(params)

    params
    |> Operation.call(:deposit)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: account}} -> {:ok, account}
    end
  end
end
