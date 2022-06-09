defmodule Repox.Users.Get do
  alias Repox.{Error, Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build(:not_found, "Usuario não encontrado")}
      user -> {:ok, user}
    end
  end
end
