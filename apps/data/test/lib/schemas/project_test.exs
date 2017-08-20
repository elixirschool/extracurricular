defmodule Data.ProjectTest do
  use Data.DataCase

  alias Data.Project

  test "project is invalid without a name" do
    changeset = Project.changeset(%Project{}, %{url: "http://example.com"})
    refute changeset.valid?
  end

  test "project is invalid without a url" do
    changeset = Project.changeset(%Project{}, %{name: "project name"})
    refute changeset.valid?
  end

  test "project is valid" do
    changeset = Project.changeset(%Project{}, %{name: "project name", url: "http://example.com"})
    assert changeset.valid?
  end

  test "project tags are optional" do
    attributes = %{name: "project name", url: "http://example.com"}
    changeset = Project.changeset(%Project{}, attributes)
    assert changeset.valid?

    changeset = Project.changeset(%Project{}, Map.put(attributes, :tags, ["one", "two"]))
    assert changeset.valid?
  end
end
