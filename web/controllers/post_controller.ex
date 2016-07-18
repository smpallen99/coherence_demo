defmodule CoherenceDemo.PostController do
  use CoherenceDemo.Web, :controller

  alias CoherenceDemo.Post
  import Canary.Plugs

  plug :load_and_authorize_resource, model: CoherenceDemo.Post, preload: [:user]
  use CoherenceDemo.ControllerAuthorization

  def index(conn, _params) do
    current_user = Coherence.current_user(conn)

    posts = conn.assigns[:posts]
    |> Enum.filter(&(&1.user_id == current_user.id || current_user.admin))
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{}) do
    render(conn, "show.html", post: conn.assigns[:post])
  end

  def edit(conn, %{}) do
    post = conn.assigns[:post]
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: conn.assigns[:post], changeset: changeset)
  end

  def update(conn, %{"post" => post_params}) do
    post = conn.assigns[:post]
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{}) do
    post = conn.assigns[:post]

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
