# RocketScience

Backend Test Task

## Usage

```elixir
iex> RocketScience.calculate_fuel(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])

🚀 Required fuel: 51898
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `rocket_science` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rocket_science, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/rocket_science>.

