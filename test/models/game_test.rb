require "test_helper"
require 'chess'


class GameTest < ActiveSupport::TestCase

  def setup
    @game = Game.new
  end 

  test 'created chess game' do 
    assert_equal Chess::Game, @game.chess_game.class
  end 

end
