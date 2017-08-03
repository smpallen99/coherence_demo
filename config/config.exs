# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :coherence_demo,
  ecto_repos: [CoherenceDemo.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :coherence_demo, CoherenceDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5/uvDSgp4hmTvBNGyr7jC3NNx+7xm7+9qGugp5DbqDvihNY+e+73kZe/A15l9MoK",
  render_errors: [view: CoherenceDemoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CoherenceDemo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: CoherenceDemo.Coherence.User,
  repo: CoherenceDemo.Repo,
  module: CoherenceDemo,
  web_module: CoherenceDemoWeb,
  router: CoherenceDemoWeb.Router,
  messages_backend: CoherenceDemoWeb.Coherence.Messages,
  require_current_password: false,
  logged_out_url: "/",
  allow_unconfirmed_access_for: 5,
  user_active_field: true,
  email_from_name: {:system, "NAME"},
  email_from_email: {:system, "EMAIL"},
  opts: [:rememberable, :unlockable_with_token, :invitable, :recoverable, :lockable, :trackable, :confirmable, :registerable, :authenticatable]

config :coherence, CoherenceDemoWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: {:system, "API_KEY"}
# %% End Coherence Configuration %%

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
