defmodule Web.OpportunitiesViewTest do
  use Web.ConnCase, async: true

  alias Web.OpportunitiesView

  test "defaults to English" do
    assert String.match? OpportunitiesView.translated_difficulty(%{level: 1}), ~r/Starter/
    assert String.match? OpportunitiesView.translated_difficulty(%{level: 5}), ~r/Intermediate/
    assert String.match? OpportunitiesView.translated_difficulty(%{level: 9}), ~r/Advanced/
  end

  test "labels problematic values unknown" do
    assert String.match? OpportunitiesView.translated_difficulty(%{level: -10}), ~r/Unknown/
  end

  test "german translations" do
    Gettext.put_locale(Web.Gettext, "de")
    assert String.match? OpportunitiesView.translated_difficulty(%{level: 1}), ~r/Leicht/
    assert String.match? OpportunitiesView.translated_difficulty(%{level: -10}), ~r/Unbekannt/
  end

end
