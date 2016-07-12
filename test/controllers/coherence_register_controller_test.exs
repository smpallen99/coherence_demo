defmodule CoherenceDemo.CoherenceRegisterControllerTest do
  use CoherenceDemo.ConnCase
  import CoherenceDemo.Router.Helpers

  alias CoherenceDemo.User
  @base_attrs %{email: "some@content", name: "some content"}
  @valid_attrs Enum.into [password: "secret", password_confirmation: "secret"], @base_attrs
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  test "renders form for new registration", %{conn: conn} do
    conn = get conn, registration_path(conn, :new)
    assert html_response(conn, 200) =~ "Register Account"
  end

  test "creates account", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), registration: @valid_attrs
    assert redirected_to(conn) == Coherence.Config.logged_out_url
    refute User.confirmed?(Repo.get_by(User, @base_attrs))
  end
end
