defmodule FirstGenServer do
  use GenServer

  def init(curr_list) do
    {:ok, curr_list |> IO.inspect(label: "init")}
  end

  # Public API
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # It will add item (PID) to the list
  def add(item),
    do: GenServer.cast(__MODULE__, {:add, item})

  def handle_cast({:add, %{id: id, percent: percent, count: count}}, curr_list),
    do: {:noreply, Map.put(curr_list, id, %{percent: percent, count: count})}

  def handle_call(:list, _from, curr_list),
    do: {:reply, curr_list, curr_list}

  # fetch process state
  def handle_call({:fetch, id}, _from, curr_list),
    do: {:reply, curr_list[id], curr_list}

  def handle_call({:remove, id}, curr_list),
    do: {:noreply, Map.drop(curr_list, [id])}

  def remove(id),
    do: GenServer.cast(__MODULE__, {:remove, id})

  def list(),
    do: GenServer.call(__MODULE__, :list)

  def fetch(id) do
    GenServer.call(__MODULE__, {:fetch, id})
  end
end
