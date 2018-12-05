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

  describe "part two" do
    test "returns the common letters between the correct box IDs" do
      input = """
      abcde
      fghij
      klmno
      pqrst
      fguij
      axcye
      wvxyz
      """
      assert DayTwo.part_two(input) == "fgij"
    end
  end
end
