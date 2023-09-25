require "test_helper"

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get game_path
    assert_response :success
  end
end
