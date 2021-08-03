defmodule Client do
  def perform_task() do
    FirstGenServer.start_link() |> IO.inspect()

    FirstGenServer.add(%{id: 23, count: 14, percent: 52})
    |> IO.inspect(label: "Record added with id #{23}")

    FirstGenServer.add(%{id: 3, count: 26, percent: 56})
    |> IO.inspect(label: "Record added with id #{3}")

    FirstGenServer.add(%{id: 62, count: 4, percent: 93})
    |> IO.inspect(label: "Record added with id #{62}")

    perform_search(4)

    # Wait for 5 seconds. To make sure async process is started
    Process.sleep(5 * 1000)

    FirstGenServer.add(%{id: 4, count: 4, percent: 93}) |> IO.inspect()
  end

  def perform_search(id),
    do: Task.async(__MODULE__, :match_a_buddy, [id])

  def match_a_buddy(id) do
    IO.inspect("function is started with id:#{id}")

    case FirstGenServer.fetch(id) do
      nil ->
        IO.inspect("[:TASK-WAITING:] No result found.")
        Process.sleep(1 * 60 * 1000)
        IO.inspect("[:SLEEP DONE:]. Trying again")
        match_a_buddy(id)

      resp ->
        resp |> IO.inspect()

        {:ok, "Got the id [#{id}], will be matched with buddy now."}
        |> IO.inspect()

        # Task completed - Remove from list now.
        # FirstGenServer.remove(id)
    end
  end
end
