defmodule CoherenceDemo.Router do
  use CoherenceDemo.Web, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, login: true
  end

  pipeline :public do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :public
    coherence_routes :public
  end
  scope "/" do
    pipe_through :browser
    coherence_routes :private
  end

  scope "/", CoherenceDemo do
    pipe_through :public
    get "/", PageController, :index
  end

  scope "/", CoherenceDemo do
    pipe_through :browser
    resources "/posts", PostController
    resources "/users", UserController
    put "/lock/:id", UserController, :lock
    put "/unlock/:id", UserController, :unlock
    put "/confirm/:id", UserController, :confirm
  end

  # Other scopes may use custom stacks.
  # scope "/api", CoherenceDemo do
  #   pipe_through :api
  # end
end
