# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CoherenceDemo.Repo.insert!(%CoherenceDemo.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

CoherenceDemo.Repo.delete_all CoherenceDemo.User

CoherenceDemo.User.changeset(%CoherenceDemo.User{}, %{name: "Demo User", email: "smpallen99@yahoo.com", password: "test", password_confirmation: "test"})
|> CoherenceDemo.Repo.insert!
|> CoherenceDemo.User.confirm!
