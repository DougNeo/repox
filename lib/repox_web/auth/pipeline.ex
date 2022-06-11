defmodule RepoxWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :repox
  alias RepoxWeb.Plugs.RefreshToken

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug RefreshToken
end
