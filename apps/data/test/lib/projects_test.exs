defmodule Data.ProjectsTest do
  use Data.DataCase

  import Data.Factory

  alias Data.Projects

  test "inserts new project when valid" do
    attributes = %{
      name: "Example project",
      url: "https://example.com"
    }

    assert {:ok, %{id: _id}} = Projects.insert(attributes)
  end

  test "gets project by attributes" do
    %{url: url} = insert(:project)
    assert %{id: _id} = Projects.get(%{url: url})
  end

  test "updates project by id" do
    %{id: id} = insert(:project)
    new_url = "https://example.com/new"
    assert {:ok, %{id: _id, url: ^new_url}} = Projects.update(id, %{url: new_url})
  end

  test "updates a given project" do
    project = insert(:project)
    new_url = "https://example.com/new"
    assert {:ok, %{id: _id, url: ^new_url}} = Projects.update(project, %{url: new_url})
  end
end
