defmodule GithubProfiler.Web.TypeaheadChannel do
  use GithubProfiler.Web, :channel

  def join("typeahead:public", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    {:ok, producer_pid} = setup_genstage(socket)
    {:noreply, assign(socket, :producer_pid, producer_pid)}
  end

  def handle_in("search", %{"query" => query}=payload, socket) do
    GithubProfiler.QueryProducer.update_query(socket.assigns.producer_pid, query)

    {:reply, :ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (typeahead:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_out("search", payload, socket) do
    push socket, "results", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  defp setup_genstage(socket) do
    {:ok, producer} = GithubProfiler.QueryProducer.start_link(
      %{socket: socket, query: ""}
    )
    {:ok, producer_consumer} = GithubProfiler.QueryProducerConsumer.start_link()
    {:ok, consumer} = GithubProfiler.QueryConsumer.start_link()
    GenStage.sync_subscribe(producer_consumer, to: producer)
    GenStage.sync_subscribe(consumer, to: producer_consumer)
    {:ok, producer}
  end
end
