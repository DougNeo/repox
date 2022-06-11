defmodule RepoxWeb.WelcomeController do
  use RepoxWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("Bem vindo a API de buscar de repositorios do GitHub \n
    \n
    \n
    1 - Para iniciar faça um POST para rota 'api/users' com uma senha, o callback te entregara um token e seu id de usuario. \n
    \n
    2 - Agora que possui o token de autenticação entre com ele nos headers da request e será possivel fazer requisição GET para a rota 'api/repositories/:username' onde deve inserir o nome do usuario a ser buscado no path da requisição. \n
    \n
    3 - Caso tenha expirado o não tenha mais o token podera solicitar um novo com um POST para 'api/users/login' passando id e senha, e será retornado um novo token.
    ")
  end
end
