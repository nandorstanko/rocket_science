defmodule RocketScience do
  alias RocketScience.ControlCenter

  @doc """
  Calculate the fuel required for a flight.

  ## Examples

      iex> RocketScience.calculate_fuel(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
      #=> 🚀 Required fuel: 51898
      :ok
  """
  @spec calculate_fuel(mass :: integer(), steps :: list()) :: :ok
  def calculate_fuel(mass, steps) do
    ControlCenter.calculate_fuel(mass, steps)
    |> format_response()
  end

  defp format_response({:error, reason}),
    do: IO.puts("💥 Houston, we have a problem...: #{reason}")

  defp format_response(required_fuel), do: IO.puts("🚀 Required fuel: #{required_fuel}")
end
