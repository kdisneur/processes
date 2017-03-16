defmodule TodoList.MyGenServer do
  def start do
    MyGenServer.start(__MODULE__, {1, []})
  end

  def add(pid, name) do
    MyGenServer.cast(pid, {:add, name})
  end

  def done(pid, id) do
    MyGenServer.call(pid, {:done, id})
  end

  def list(pid) do
    MyGenServer.call(pid, :list)
  end

  def remove(pid, id) do
    MyGenServer.call(pid, {:remove, id})
  end

  def handle_call({:done, current_id}, _pid, {id, list}) do
    {:reply, :ok, {id, TodoList.done(list, current_id)}}
  end
  def handle_call(:list, _pid, state = {_id, list}) do
    {:reply, list, state}
  end
  def handle_call({:remove, current_id}, _pid, {id, list}) do
    {:reply, :ok, {id, TodoList.remove(list, current_id)}}
  end

  def handle_cast({:add, name}, {id, list}) do
    {:noreply, {id + 1, TodoList.add(list, id, name)}}
  end
end
