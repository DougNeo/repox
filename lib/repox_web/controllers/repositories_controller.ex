defmodule RepoxWeb.RepositoriesController do
  use RepoxWeb, :controller

  alias Repox.Github.Client

  action_fallback RepoxWeb.FallbackController

  def index(conn, params) do

    with {:ok, repositories} <- Client.get_repo(params["username"]),
     ["Bearer " <> new_token] <- get_req_header(conn, "authorization") do
      conn
      |> put_status(:ok)
      |> render("index.json", repositories: repositories, new_token: new_token)
    end
  end
end
