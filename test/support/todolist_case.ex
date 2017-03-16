defmodule TodoList.Case do
  use ExUnit.CaseTemplate

  defmacro __using__(module)  do
    quote do
      use ExUnit.Case

      alias unquote(module), as: Server

      test "start: returns a PID" do
        {:ok, pid} = Server.start

        assert Process.alive?(pid)
      end

      test "add: adds new todo in a todo list" do
        {:ok, pid} = Server.start

        assert :ok == Server.add(pid, "Code")
        assert :ok == Server.add(pid, "Eat")
        assert [{1, "Code", false}, {2, "Eat", false}] == Server.list(pid)
      end

      test "done: mark a todo as done" do
        {:ok, pid} = Server.start

        assert :ok == Server.add(pid, "Code")
        assert :ok == Server.add(pid, "Eat")
        assert :ok == Server.done(pid, 2)
        assert [{1, "Code", false}, {2, "Eat", true}] == Server.list(pid)
      end

      test "remove: deletes a todo" do
        {:ok, pid} = Server.start

        assert :ok == Server.add(pid, "Code")
        assert :ok == Server.add(pid, "Eat")
        assert [{1, "Code", false}, {2, "Eat", false}] == Server.list(pid)
        assert :ok == Server.remove(pid, 2)
        assert [{1, "Code", false}] == Server.list(pid)
      end
    end
  end
end
