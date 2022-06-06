defmodule Repox.Github.ClientTest do
  use ExUnit.Case, async: true
  alias Repox.Github.Client
  alias Plug.Conn
  alias Repox.Error

  describe "get_repo/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid repo, returns the list os repo for user", %{bypass: bypass} do
      user = "minishaw"

      url = endpoint_url(bypass.port)

      body = ~s([{"id": 393942628, "name": "Minishaw", "html_url": "https://github.com/Minishaw/Minishaw", "description": "Config files for my GitHub profile.", "stargazers_count": 0}])

      Bypass.expect(bypass, "GET", "/users/#{user}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_repo(url, user)

      expected_response =
        {:ok,
        [
          %{
            "description" => "Config files for my GitHub profile.",
            "html_url" => "https://github.com/Minishaw/Minishaw",
            "id" => 393_942_628,
            "name" => "Minishaw",
            "stargazers_count" => 0
          }
        ]}

      assert response == expected_response
    end

    test "when there respo is invalid, returns an error", %{bypass: bypass} do
      user = "minish4w"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "/users/#{user}/repos", fn conn ->
        Conn.resp(conn, 404, '')
      end)

      response = Client.get_repo(url, user)

      expected_response = {:error, %Error{result: "Usuario não encontrado", status: :not_found}}

      assert response == expected_response
    end

    test "when there not conection, returns an error", %{bypass: bypass} do
      user = "minish4w"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_repo(url, user)

      expected_response = {:error, %Error{result: ":econnrefused", status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}"
  end
end
