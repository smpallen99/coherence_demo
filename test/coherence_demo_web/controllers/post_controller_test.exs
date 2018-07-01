defmodule CoherenceDemoWeb.PostControllerTest do
  use CoherenceDemoWeb.ConnCase

  alias CoherenceDemo.Blogs

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  setup %{conn: conn} do
    user =
      %CoherenceDemo.Coherence.User{}
      |> CoherenceDemo.Coherence.User.changeset(%{
        name:  "Foo",
        email: "foo@bar.com",
        password:  "foobar",
        password_confirmation:  "foobar"
      })
      |> CoherenceDemo.Repo.insert!()

    {:ok, conn: assign(conn, :current_user, user), user: user}
  end

  def fixture(:post) do
    {:ok, post} = Blogs.create_post(@create_attrs)
    post
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get conn, post_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Posts"
    end
  end

  describe "new post" do
    test "renders form", %{conn: conn} do
      conn = get conn, post_path(conn, :new)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = conn.assigns.current_user
      conn = post conn, post_path(conn, :create), post: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == post_path(conn, :show, id)

      conn = build_conn()
      conn = assign(conn, :current_user, user)
      conn = get conn, post_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Post"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, post_path(conn, :create), post: @invalid_attrs
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    setup [:create_post]

    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get conn, post_path(conn, :edit, post)
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post]

    test "redirects when data is valid", %{conn: conn, post: post} do
      user = conn.assigns.current_user
      conn = put conn, post_path(conn, :update, post), post: @update_attrs
      assert redirected_to(conn) == post_path(conn, :show, post)

      conn = build_conn()
      conn = assign(conn, :current_user, user)
      conn = get conn, post_path(conn, :show, post)
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put conn, post_path(conn, :update, post), post: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      user = conn.assigns.current_user
      conn = delete conn, post_path(conn, :delete, post)

      assert redirected_to(conn) == post_path(conn, :index)
      conn = build_conn()
      conn = assign(conn, :current_user, user)
      assert_error_sent 404, fn ->
        get conn, post_path(conn, :show, post)
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    {:ok, post: post}
  end
end
