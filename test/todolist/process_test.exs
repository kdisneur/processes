defmodule TodoList.ProcessTest do
  use ExUnit.Case

  test "start: returns a PID" do
    {:ok, pid} = TodoList.Process.start

    assert Process.alive?(pid)
  end

  test "add: adds new todo in a todo list" do
    {:ok, pid} = TodoList.Process.start

    send(pid, {:add, "Code"})
    send(pid, {:add, "Eat"})

    send(pid, {:list, self()})
    assert_receive {:reply, [{1, "Code", false}, {2, "Eat", false}]}
  end

  test "done: mark a todo as done" do
    {:ok, pid} = TodoList.Process.start

    send(pid, {:add, "Code"})
    send(pid, {:add, "Eat"})
    send(pid, {{:done, 2}, self()})

    send(pid, {:list, self()})
    assert_receive {:reply, [{1, "Code", false}, {2, "Eat", true}]}
  end

  test "remove: deletes a todo" do
    {:ok, pid} = TodoList.Process.start

    send(pid, {:add, "Code"})
    send(pid, {:add, "Eat"})

    send(pid, {:list, self()})
    assert_receive {:reply, [{1, "Code", false}, {2, "Eat", false}]}

    send(pid, {{:remove, 2}, self()})

    send(pid, {:list, self()})
    assert_receive {:reply, [{1, "Code", false}]}
  end
end
