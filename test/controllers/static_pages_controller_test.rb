require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'
    assert_select 'title', 'Chess'
  end

  test "should get opponent_setup" do
    get opponent_setup_path
    assert_response :success
    assert_template 'static_pages/opponent_setup'
    assert_select 'title', 'Setup Game | Chess'
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_template 'static_pages/about'
    assert_select 'title', 'About | Chess'
  end

  test "should get game" do
    get game_path
    assert_response :success
    assert_template 'static_pages/game'
    assert_select 'title', 'Playing | Chess'
  end
end
