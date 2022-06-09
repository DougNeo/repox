defmodule RepoxWeb.UsersController do
  use RepoxWeb, :controller

  alias Repox.User
  alias RepoxWeb.{FallbackController, Auth.Guardian}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Repox.Users.Create.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user, token: token)
    end
  end

  def login(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("login.json", token: token)
    end
  end
end
