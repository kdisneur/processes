defmodule TodoList do
  def add(list, id, name) do
    list ++ [{id, name, false}]
  end

  def remove(list, id) do
    Enum.reject(list, fn {todo_id, _name, _state} -> id == todo_id end)
  end

  def done(list, id) do
    Enum.map(list, fn {^id, name, _state} -> {id, name, true}
                      item -> item end)
  end
end
