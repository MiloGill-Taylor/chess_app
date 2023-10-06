require "test_helper"


class GamesHelperTest < ActiveSupport::TestCase

  test "square_number_to_name" do 
    squares_to_name = { 19 => 'd3', 42 => 'c6',
                        7 => 'h1', 63 => 'h8',
                        32 => 'a5', 46 => 'g6',
                        58 => 'c8'}
    squares_to_name.each_key do |key|
      assert_equal squares_to_name[key], square_number_to_name(key)
    end 
  end
end