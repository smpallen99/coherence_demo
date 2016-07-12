defmodule CoherenceDemo.LockController do
  use CoherenceDemo.Web, :controller
  alias CoherenceDemo.{User}
  use Timex

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
        {field, {err, _}} when is_binary(err) or is_atom(err) ->
          "#{field}: #{err}"
        other -> inspect other
      end
    end
    |> Enum.join("<br \>\n")
  end
end
