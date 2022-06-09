defmodule RepoxWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :repox

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
