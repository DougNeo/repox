defmodule RepoxWeb.RepositoriesController do
  use RepoxWeb, :controller

  alias Repox.Github.Client

  action_fallback RepoxWeb.FallbackController

  def index(conn, params) do
    with {:ok, repositories} <- Client.get_repo(params["username"]) do
      conn
      |> put_status(:ok)
      |> render("index.json", repositories: repositories)
    end
  end
end
