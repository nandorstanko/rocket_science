defmodule RocketScience.ControlCenter do
  @moduledoc ~S"""
  Dynamic supervisor for controlling processes responsible for various top secret calculations
  """

  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one, extra_arguments: [init_arg])
  end

  @spec calculate_fuel(mass :: integer(), steps :: list({:launch | :land, float()})) ::
          integer() | {:error, binary()}
  def calculate_fuel(mass, steps) do
    with {:ok, calculator} <-
           DynamicSupervisor.start_child(__MODULE__, {RocketScience.Calculator, mass}) do
      GenServer.call(calculator, {:calculate, steps})
    end
  end
end
