defmodule CoherenceDemoWeb.Router do
  use CoherenceDemoWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true  # Add this
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Add this block
  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  # Add this block
  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", CoherenceDemoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", CoherenceDemoWeb do
    pipe_through :protected # Use the default browser stack

    resources "/posts", PostController
    resources "/users", UserController
    put "/lock/:id", UserController, :lock
    put "/unlock/:id", UserController, :unlock
    put "/confirm/:id", UserController, :confirm
  end

  # Other scopes may use custom stacks.
  # scope "/api", CoherenceDemoWeb do
  #   pipe_through :api
  # end
end
