defmodule CoherenceDemo.User do
  use CoherenceDemo.Web, :model
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    coherence_schema

    timestamps
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email] ++ coherence_fields)
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end
  def changeset(model, params, which) do
    IO.puts "new changeset, which: #{inspect which}"
    changeset model, params
  end
end
