defmodule RepoxWeb.UsersView do
  use RepoxWeb, :view

  alias Repox.User

  def render("create.json", %{ user: user, token: token}) do
    %{id: user.id, token: token}
  end

  def render("user.json", %{user: %User{}} = user) do
    %{user: user}
  end

  def render("login.json", %{token: token}) do
    %{token: token}
  end
end
