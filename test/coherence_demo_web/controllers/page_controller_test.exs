defmodule CoherenceDemoWeb.PageControllerTest do
  use CoherenceDemoWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "An full-featured authentication package"
  end
end
