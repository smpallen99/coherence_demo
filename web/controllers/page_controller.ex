defmodule CoherenceDemo.PageController do
  use CoherenceDemo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
