require "test_helper"

class GameTest < ActiveSupport::TestCase
  test 'created chess game' do 
    g = Game.new
    g.initialize_chess_game
    assert_not_nil g.chess_game
  end 
end
