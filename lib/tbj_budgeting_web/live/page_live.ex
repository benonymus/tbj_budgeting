defmodule TbjBudgetingWeb.PageLive do
  use TbjBudgetingWeb, :live_view
  alias TbjBudgeting.Calculations.{Calculation, Value}

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      Calculation.changeset(%Calculation{}, %{pluses: [%{value: 0}], minuses: [%{value: 0}]})

    {:ok, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event(
        "calculate",
        %{"calculation" => %{"pluses" => pluses, "minuses" => minuses}},
        socket
      ) do
    changeset = Calculation.changeset(%Calculation{}, %{pluses: pluses, minuses: minuses})

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event(
        "add_value",
        %{"action" => action},
        socket
      ) do
    action =
      case action do
        "plus" -> :pluses
        "minus" -> :minuses
      end

    changeset = Value.add_value(socket.assigns.changeset, action)

    {:noreply, assign(socket, changeset: changeset)}
  end
end
