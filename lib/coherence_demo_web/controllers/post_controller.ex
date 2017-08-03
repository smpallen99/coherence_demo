defmodule CoherenceDemoWeb.PostController do
  use CoherenceDemoWeb, :controller

  alias CoherenceDemo.Blogs
  alias CoherenceDemo.Blogs.Post

  def index(conn, _params) do
    posts = Blogs.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Blogs.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Blogs.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blogs.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blogs.get_post!(id)
    changeset = Blogs.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blogs.get_post!(id)

    case Blogs.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blogs.get_post!(id)
    {:ok, _post} = Blogs.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
