defmodule CoherenceDemo.ControllerAuthorization do
  @moduledoc """
  Add authorization check to a controller.

  """
  defmacro __using__(_) do
    quote do
      plug :check_authorized

      defp check_authorized(%{assigns: %{authorized: true}} = conn, _) do
        conn
      end
      defp check_authorized(conn, _) do
        conn
        |> put_flash(:error, "You are not authorized")
        |> redirect(to: "/")
        |> halt
      end
    end
  end
end
