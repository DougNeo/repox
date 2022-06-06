defmodule Repox.Github.Client do
  use Tesla

  alias Tesla.Env
  alias Repox.Error

  @base_url "https://api.github.com"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]

  def get_repo(url \\ @base_url, user) do
    "#{url}/users/#{user}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    repos =
      body
      |> Enum.map(fn x ->
        Map.take(x, ["id", "name", "description", "html_url", "stargazers_count"])
      end)

    {:ok, repos}
  end

  defp handle_get({:ok, %Env{status: 404, body: _body}}) do
    {:error, Error.build(:not_found, "Usuario não encontrado")}
  end

  defp handle_get({:error, :econnrefused}) do
    {:error, Error.build(:bad_request, ":econnrefused")}
  end
end
