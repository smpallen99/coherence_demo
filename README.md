# CoherenceDemo

A Coherence Demo project illustrating how to use [Coherence](https://github.com/smpallen99/coherence).

This project demonstrates some of the features of Coherence on a very simple project.

> Updated for Phoenix 1.3

## Installation

```bash
  $ git clone https://github.com/smpallen99/coherence_demo.git
  $ cd coherence_demo
  $ mix do deps.get, deps.compile
  $ mix ecto.setup
  $ cd assets && npm install
  $ iex -S mix phx.server
```

Visit http://localhost:4008/ in your browser

Default login created with `mix ecto.setup` is demouser@example.com / secret

Note, you will need to setup an sendgrid API key in config/config.exs to get the outgoing emails to work

## How was this project created

```bash
  $ mix phx.new coherence_demo --binary-id
  $ cd coherence_demo
  $ mix ecto.setup

  # edit mix.exs and add coherence deps
  $ mix coherence.install --full --invitable --registerable --rememberable --confirmable --user-active-field

  # edit web/router.ex and add the coherence routes per the instructions
  # edit priv/repo/seeds.exs -- add User seeds
  # edit web/templates/layout/app.html.eex -- add some nav stuff

  # added the `user_controller`, view, and templates manually
  # added some custom routes for the lock/unlock/etc behaviour

  $mix ecto.setup
```
