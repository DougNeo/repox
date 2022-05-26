defmodule RepoxWeb.PageController do
  use RepoxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
