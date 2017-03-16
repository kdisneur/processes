defmodule TodoList.Process do
  def start do
    {:ok, spawn(fn -> loop({1, []}) end)}
  end

  def add(pid, name) do
    send(pid, {:add, name})

    :ok
  end

  def done(pid, id) do
    send(pid, {{:done, id}, self()})

    receive do
      {:reply, value} ->
        value
    end
  end

  def list(pid) do
    send(pid, {:list, self()})

    receive do
      {:reply, value} ->
        value
    end
  end

  def remove(pid, id) do
    send(pid, {{:remove, id}, self()})

    receive do
      {:reply, value} ->
        value
    end
  end

  defp loop({id, list}) do
    receive do
      {:add, name} ->
        loop({id + 1, TodoList.add(list, id, name)})
      {{:done, current_id}, pid} ->
        new_list = TodoList.done(list, current_id)
        send(pid, {:reply, :ok})
        loop({id, new_list})
      {:list, pid} ->
        send(pid, {:reply, list})
        loop({id, list})
      {{:remove, current_id}, pid} ->
        new_list = TodoList.remove(list, current_id)
        send(pid, {:reply, :ok})
        loop({id, new_list})
    end
  end
end
