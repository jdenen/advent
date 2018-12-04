defmodule DayOneTest do
  use ExUnit.Case

  describe "part one" do
    test "+1, +1, +1 is 3" do
      input = """
      +1
      +1
      +1
      """
      assert DayOne.part_one(input) == 3
    end

    test "+1, +1, -2 is 0" do
      input = """
      +1
      +1
      -2
      """
      assert DayOne.part_one(input) == 0
    end

    test "-1, -2, -3 is -6" do
      input = """
      -1
      -2
      -3
      """
      assert DayOne.part_one(input) == -6
    end
  end

  describe "part two" do
    test "+1, -1 reaches 0 twice" do
      input = """
      +1
      -1
      """
      assert DayOne.part_two(input) == 0
    end

    test "+3, +3, +4, -2, -4 reaches 10 twice" do
      input = """
      +3
      +3
      +4
      -2
      -4
      """
      assert DayOne.part_two(input) == 10
    end

    test "-6, +3, +8, +5, -6 reaches 5 first" do
      input = """
      -6
      +3
      +8
      +5
      -6
      """
      assert DayOne.part_two(input) == 5
    end

    test "+7, +7, -2, -7, -4 reaches 14 twice" do
      input = """
      +7
      +7
      -2
      -7
      -4
      """
      assert DayOne.part_two(input) == 14
    end
  end
end
