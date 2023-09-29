require "test_helper"
require 'chess'


class GameTest < ActiveSupport::TestCase

  def setup
    @game = games(:game1)
    @game.initialize_chess_game
  end 

  test 'created chess game' do 
    assert_equal Chess::Game, @game.chess_game.class
  end 

  test "status should be present" do 
    @game.status = "    "
    assert_not @game.valid?
  end 

  test "status must be valid" do 
    valid_states = %w[in_progress white_won black_won 
                      white_won_resign black_won_resign 
                      stalemate insufficient_material 
                      fifty_move_rule threefold_repitition]

    valid_states.each do |state|
      @game.status = state 
      assert @game.valid?
    end 

    @game.status = 'not valid'
    assert_not @game.valid?
  end 

  test "load game" do 
    assert_equal 4, @game.moves.count # Check the game has the moves
    @game.load_game 
    assert_equal 4, @game.chess_game.moves.length
  end 

end
