defmodule Repox.Repo do
  use Ecto.Repo,
    otp_app: :repox,
    adapter: Ecto.Adapters.Postgres
end
