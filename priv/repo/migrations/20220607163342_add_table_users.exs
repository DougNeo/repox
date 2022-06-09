defmodule Repox.Repo.Migrations.AddTableUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :password_hash, :string
    end
  end
end
