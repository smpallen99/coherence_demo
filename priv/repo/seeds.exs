CoherenceDemo.Repo.delete_all CoherenceDemo.Coherence.User

CoherenceDemo.Coherence.User.changeset(%CoherenceDemo.Coherence.User{}, %{name: "Demo User", email: "demouser@example.com", password: "secret", password_confirmation: "secret"})
|> CoherenceDemo.Repo.insert!
|> Coherence.Controller.confirm!
