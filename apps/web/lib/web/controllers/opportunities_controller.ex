defmodule Web.OpportunitiesController do
  use Web, :controller

  alias Data.Opportunities

  def index(conn, _params) do
    results = Opportunities.all()
    render(conn, "opportunities.html", results: results)
  end
end