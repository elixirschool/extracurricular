defmodule Web.OpportunitiesControllerTest do
  use Web.ConnCase

  test "GET /list", %{conn: conn} do
    conn = get conn, "/list"
    assert html_response(conn, 200) =~ "Extracurricular"
  end
end
