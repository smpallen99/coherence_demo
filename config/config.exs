# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :coherence_demo,
  ecto_repos: [CoherenceDemo.Repo]

# Configures the endpoint
config :coherence_demo, CoherenceDemo.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fTFYZEpE/kju9exPqROgdfG70aYEQz/qAKJ/SowNcfkiBf9etSamqKe3X8bp7Q9C",
  render_errors: [view: CoherenceDemo.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CoherenceDemo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: CoherenceDemo.User,
  repo: CoherenceDemo.Repo,
  module: CoherenceDemo,
  # changeset: {CoherenceDemo.User, :changeset},
  logged_out_url: "/",
  email_from: {"E-MetroTel", "steve.pallen@emetrotel.com"},
  opts: [:rememberable, :unlockable_with_token, :invitable, :authenticatable, :recoverable, :lockable, :trackable, :confirmable, :registerable]

config :coherence, CoherenceDemo.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "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"
# %% End Coherence Configuration %%
