defmodule DayTwoTest do
  use ExUnit.Case

  describe "part one" do
    test "produces the number of boxes with IDs containing a letter exactly twice and/or thrice" do
      input = """
      abcdef
      bababc
      abbcde
      abcccd
      aabcdd
      abcdee
      ababab
      """
      assert DayTwo.part_one(input) == 12
    end
  end
end
