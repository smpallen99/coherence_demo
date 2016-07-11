# CoherenceDemo

A Coherence Demo project illustrating how to use [Coherence](https://github.com/smpallen99/coherence).

Project creation:

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

