defmodule RocketScience.ControlCenterTest do
  use ExUnit.Case

  alias RocketScience.ControlCenter

  describe "calculate_fuel/2" do
    test "Apollo 11" do
      assert 51898 =
               ControlCenter.calculate_fuel(28801, [
                 {:launch, 9.807},
                 {:land, 1.62},
                 {:launch, 1.62},
                 {:land, 9.807}
               ])
    end

    test "Mission on Mars" do
      assert 33388 =
               ControlCenter.calculate_fuel(14606, [
                 {:launch, 9.807},
                 {:land, 3.711},
                 {:launch, 3.711},
                 {:land, 9.807}
               ])
    end

    test "Passenger ship" do
      assert 212_161 =
               ControlCenter.calculate_fuel(75432, [
                 {:launch, 9.807},
                 {:land, 1.62},
                 {:launch, 1.62},
                 {:land, 3.711},
                 {:launch, 3.711},
                 {:land, 9.807}
               ])
    end
  end
end
