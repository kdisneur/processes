defmodule TodoList.ProcessTest do
  use ExUnit.Case

  test "start: returns a PID" do
    {:ok, pid} = TodoList.Process.start

    assert Process.alive?(pid)
  end

  test "add: adds new todo in a todo list" do
    {:ok, pid} = TodoList.Process.start

    assert :ok == TodoList.Process.add(pid, "Code")
    assert :ok == TodoList.Process.add(pid, "Eat")
    assert [{1, "Code", false}, {2, "Eat", false}] == TodoList.Process.list(pid)
  end

  test "done: mark a todo as done" do
    {:ok, pid} = TodoList.Process.start

    assert :ok == TodoList.Process.add(pid, "Code")
    assert :ok == TodoList.Process.add(pid, "Eat")
    assert :ok == TodoList.Process.done(pid, 2)
    assert [{1, "Code", false}, {2, "Eat", true}] == TodoList.Process.list(pid)
  end

  test "remove: deletes a todo" do
    {:ok, pid} = TodoList.Process.start

    assert :ok == TodoList.Process.add(pid, "Code")
    assert :ok == TodoList.Process.add(pid, "Eat")
    assert [{1, "Code", false}, {2, "Eat", false}] == TodoList.Process.list(pid)
    assert :ok == TodoList.Process.remove(pid, 2)
    assert [{1, "Code", false}] == TodoList.Process.list(pid)
  end
end
