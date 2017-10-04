defmodule Web.Guardian do
  use Guardian, otp_app: :web

  def subject_for_token(resource, _claims), do: {:ok, to_string(resource.id)}
  def subject_for_token(_, _), do: {:error, :auth_error}

  def resource_from_claims(claims), do: {:ok, find_me_a_resource(claims["sub"])}
  def resource_from_claims(_claims), do: {:error, :auth_error}
end
