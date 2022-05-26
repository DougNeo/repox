defmodule RepoxWeb.FallbackController do
  use RepoxWeb, :controller

  alias Repox.Error
  alias RepoxWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
