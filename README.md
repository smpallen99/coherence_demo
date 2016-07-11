# CoherenceDemo

A Coherence Demo project illustrating how to use [Coherence](https://github.com/smpallen99/coherence).

## Installation

```bash
  $ git clone https://github.com/smpallen99/coherence_demo.git
  $ cd coherence_demo
  $ mix do deps.get, deps.compile
  $ mix ecto.setup
  $ iex -S mix phoenix.server
```

Visit http://localhost:4008/ in your browser

Default login created with `mix ecto.setup` is demouser@example.com / secret

Note, you will need to setup an sendgrid API key in config/config.exs to get the outgoing emails to work

## How was this project created

```bash
  $ mix phoenix.new coherence_demo
  $ cd coherence_demo
  $ mix ecto.setup

  # edit mix.exs and add coherence deps and add :coherence to applications
  $ mix coherence.install --full --invitable --registerable --rememberable --confirmable

  # edit web/router.ex and add the coherence routes per the instructions
  # edit priv/repo/seeds.exs -- add User seeds
  # edit web/templates/layout/app.html.eex -- add some nav stuff

  $mix ecto.setup
```

