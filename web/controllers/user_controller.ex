defmodule CoherenceDemo.UserController do
  use CoherenceDemo.Web, :controller
  use Timex
  import Canary.Plugs
  alias CoherenceDemo.User

  plug :load_and_authorize_resource, model: CoherenceDemo.User
  use CoherenceDemo.ControllerAuthorization

  def index(conn, _params) do
    render(conn, "index.html", users: conn.assigns[:users])
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{}) do
    render(conn, "show.html", user: conn.assigns[:user])
  end

  def edit(conn, %{}) do
    user = conn.assigns[:user]
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"user" => user_params}) do
    user = conn.assigns[:user]
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{}) do
    user = conn.assigns[:user]

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  def confirm(conn, %{"id" => id}) do
    case Repo.get User, id do
      nil ->
        conn
        |> put_flash(:error, "User not found")
        |> redirect(to: user_path(conn, :index))
      user ->
        case User.confirm! user do
          {:error, changeset}  ->
            conn
            |> put_flash(:error, format_errors(changeset))
          _ ->
            put_flash(conn, :info, "User confirmed!")
        end
        |> redirect(to: user_path(conn, :show, user.id))
    end
  end

  def lock(conn, %{"id" => id}) do
    locked_at = DateTime.now
    |> Timex.shift(years: 10)

    case Repo.get User, id do
      nil ->
        conn
        |> put_flash(:error, "User not found")
        |> redirect(to: user_path(conn, :index))
      user ->
        case User.lock! user, locked_at do
          {:error, changeset}  ->
            conn
            |> put_flash(:error, format_errors(changeset))
          _ ->
            put_flash(conn, :info, "User locked!")
        end
        |> redirect(to: user_path(conn, :show, user.id))
    end
  end

  def unlock(conn, %{"id" => id}) do
    case Repo.get User, id do
      nil ->
        conn
        |> put_flash(:error, "User not found")
        |> redirect(to: user_path(conn, :index))
      user ->
        case User.unlock! user do
          {:error, changeset}  ->
            conn
            |> put_flash(:error, format_errors(changeset))
          _ ->
            put_flash(conn, :info, "User locked!")
        end
        |> redirect(to: user_path(conn, :show, user.id))
    end
  end
  defp format_errors(changeset) do
    for error <- changeset.errors do
      case error do
        {:locked_at, {err, _}} -> err
        {_field, {err, _}} when is_binary(err) or is_atom(err) ->
          "#{err}"
        other -> inspect other
      end
    end
    |> Enum.join("<br \>\n")
  end
end
