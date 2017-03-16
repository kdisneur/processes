defmodule TodoListTest do
  use ExUnit.Case

  setup do
    list =
      []
      |> TodoList.add(1, "Code")
      |> TodoList.add(2, "Eat")
      |> TodoList.add(3, "Sleep")

    {:ok, list: list}
  end

  test "add: add a new todo to an empty todolist" do
    assert [{1, "Code", false}] == TodoList.add([], 1, "Code")
  end

  test "add: add a new todo to an existing todolist", %{list: list} do
    expected_list =
      [{1, "Code", false},
       {2, "Eat", false},
       {3, "Sleep", false},
       {4, "Repeat", false}]

    assert expected_list == TodoList.add(list, 4, "Repeat")
  end

  test "remove: remove a non existing todo", %{list: list} do
    assert list == TodoList.remove(list, 42)
  end

  test "remove: remove an existing todo", %{list: list} do
    assert [{1, "Code", false}, {3, "Sleep", false}] == TodoList.remove(list, 2)
  end

  test "done: mark an existing todo as done", %{list: list} do
    assert list == TodoList.done(list, 42)
  end

  test "done: mark a non existing todo as done", %{list: list} do
    assert [{1, "Code", false}, {2, "Eat", true}, {3, "Sleep", false}] == TodoList.done(list, 2)
  end
end
