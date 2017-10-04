defmodule Web.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :web

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
end
