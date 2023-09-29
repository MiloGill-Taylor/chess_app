require "test_helper"

class MoveTest < ActiveSupport::TestCase

  test "moves should be returned in order of creation" do 
    assert_equal moves(:first), Move.first 
  end 
end
