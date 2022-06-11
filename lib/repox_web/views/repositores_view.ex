defmodule RepoxWeb.RepositoriesView do
  use RepoxWeb, :view

  def render("index.json", %{repositories: repositories, new_token: new_token}) do
    %{
      repositories:
        Enum.map(repositories, fn repository ->
          %{
            name: repository["name"],
            description: repository["description"],
            id: repository["id"],
            html_url: repository["html_url"],
            stargazers_count: repository["stargazers_count"]
          }
        end),
      token: new_token
    }
  end
end
