defmodule Web.Locale do
  @moduledoc """
  Plug to pull the locale from either a parameter or the session and
  pass it on to Gettext for serving up the appropriate translations
  """

  import Plug.Conn

  def init(_opts), do: nil

  def call(conn, _opts) do
    case conn.params["locale"] || get_session(conn, :locale) do
      nil -> conn
      locale ->
        Gettext.put_locale(Web.Gettext, locale)
        put_session(conn, :locale, locale)
    end
  end
end
