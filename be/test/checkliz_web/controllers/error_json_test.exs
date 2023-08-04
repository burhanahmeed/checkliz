defmodule ChecklizWeb.ErrorJSONTest do
  use ChecklizWeb.ConnCase, async: true

  test "renders 404" do
    assert ChecklizWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ChecklizWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
