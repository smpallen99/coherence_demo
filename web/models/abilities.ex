alias CoherenceDemo.{User, Post}

defimpl Canada.Can, for: User do
  def can?(%User{admin: true}, _, _), do: true
  def can?(%User{id: user_id}, action, %User{id: user_id}) when action in [:show, :edit, :update], do: true
  def can?(%User{id: user_id}, action, Post) when action in ~w(index new create)a, do: true
  def can?(%User{id: user_id}, _, %Post{user_id: user_id}), do: true

  def can?(_, _, _), do: false
end

