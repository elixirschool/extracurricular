defmodule Bot.GitHubTest do
  use ExUnit.Case

  alias Bot.GitHub

  setup do
    bypass = Bypass.open(port: 1234)
    {:ok, bypass: bypass}
  end

  test "retreives all open and unassigned issues for a repo", %{bypass: bypass} do
    Bypass.expect(bypass, &request/1)
    issues = GitHub.issues("example/project")
    assert length(issues) == 2
    assert ["one", "two"] == Enum.map(issues, &(&1["title"]))
  end

  defp request(%{query_string: "assignee=none&state=open&page=1"} = conn) do
    link = "<https://localhost:1234/repo/example/project/issues?assignee=none&state=open&page=2>; rel=\"next\""

    conn
    |> Plug.Conn.put_resp_header("Link", link)
    |> Plug.Conn.resp(200, Poison.encode!([%{title: "one"}]))
  end

  defp request(%{query_string: "assignee=none&state=open&page=2"} = conn) do
    link = "https://localhost:1234/repo/example/project/issues?assignee=none&state=open&page=1>; rel=\"next\""

    conn
    |> Plug.Conn.put_resp_header("Link", link)
    |> Plug.Conn.resp(200, Poison.encode!([%{title: "two"}]))
  end

  test "does not retreive pull requests for a repo", %{bypass: bypass} do
    Bypass.expect(bypass, &request2/1)
    issues = GitHub.issues("another/project")
    assert length(issues) == 1
    assert ["one"] == Enum.map(issues, &(&1["title"]))
  end

  defp request2(%{query_string: "assignee=none&state=open&page=1"} = conn) do
    link = "https://localhost:1234/repo/another/project/issues?assignee=none&state=open&page=1>; rel=\"next\""

    conn
    |> Plug.Conn.put_resp_header("Link", link)
    |> Plug.Conn.resp(200, Poison.encode!([%{title: "one"}]))
  end

  defp request2(%{query_string: "assignee=none&state=open&page=2"} = conn) do
    link = "https://localhost:1234/repo/another/project/issues?assignee=none&state=open&page=1>; rel=\"next\""

    conn
    |> Plug.Conn.put_resp_header("Link", link)
    |> Plug.Conn.resp(200, Poison.encode!([%{title: "two", pull_request: "something"}]))
  end

end
