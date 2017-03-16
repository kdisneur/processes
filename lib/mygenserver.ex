defmodule MyGenServer do
  def start(callback_module, initial_state) do
    {:ok, spawn(fn -> loop(callback_module, initial_state) end)}
  end

  def call(pid, message) do
    send(pid, {:call, message, self()})

    receive do
      {:reply, value} ->
        value
    end
  end

  def cast(pid, message) do
    send(pid, {:cast, message})

    :ok
  end

  defp loop(callback_module, state) do
    receive do
      {:call, message, caller} ->
        {:reply, value, state} = apply(callback_module, :handle_call, [message, caller, state])
        send(caller, {:reply, value})
        loop(callback_module, state)
      {:cast, message} ->
        {:noreply, state} = apply(callback_module, :handle_cast, [message, state])
        loop(callback_module, state)
    end
  end
end
