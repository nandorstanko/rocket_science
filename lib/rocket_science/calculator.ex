defmodule RocketScience.Calculator do
  use GenServer, restart: :transient

  def start_link([], equipment) do
    GenServer.start_link(__MODULE__, equipment)
  end

  @impl true
  def init(equipment) when is_integer(equipment) and equipment > 0 do
    {:ok, %{equipment: equipment, mass: equipment}}
  end

  def init(_equipment) do
    {:error, "initial equipment weight must be a positive integer"}
  end

  @impl true
  def handle_call({:calculate, steps}, from, state) when is_list(steps) do
    {:noreply, Map.put(state, :from, from), {:continue, Enum.reverse(steps)}}
  end

  def handle_call({:calculate, _steps}, _from, state) do
    {:stop, :normal, {:error, "path must be a list"}, state}
  end

  @allowed_directives ~w(launch land)a

  @impl true
  def handle_continue([{directive, gravity} = step | tail] = _steps, %{mass: mass} = state)
      when directive in @allowed_directives and is_number(gravity) do
    mass =
      calculate_action(step, mass, mass)

    {:noreply, Map.put(state, :mass, mass), {:continue, tail}}
  end

  def handle_continue([], %{equipment: equipment, mass: mass, from: from} = state) do
    GenServer.reply(from, mass - equipment)

    {:stop, :normal, state}
  end

  def handle_continue(_, %{from: from} = state) do
    GenServer.reply(
      from,
      {:error, "invalid directive, valid formats: {:land, 9.807} or {:launch, 9.807}"}
    )

    {:stop, :normal, state}
  end

  defp calculate_action(_step, mass, acc) when mass <= 0, do: acc

  defp calculate_action({:launch, gravity} = step, mass, acc) do
    required_fuel =
      (mass * gravity * 0.042 - 33)
      |> floor()

    calculate_action(step, required_fuel, acc + max(required_fuel, 0))
  end

  defp calculate_action({:land, gravity} = step, mass, acc) do
    required_fuel =
      (mass * gravity * 0.033 - 42)
      |> floor()

    calculate_action(step, required_fuel, acc + max(required_fuel, 0))
  end
end
