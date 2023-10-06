require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'
    assert_select 'title', 'Chess'
    assert_select 'a[href=?]', about_path
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_template 'static_pages/about'
    assert_select 'title', 'About | Chess'
  end

end
