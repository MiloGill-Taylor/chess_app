require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  def setup
    @valid_user = User.new(name: 'milo', email: 'milo@gill-taylor.com',
                           password: 'password', password_confirmation: 'password')
  end 

  test "should get sign up page" do 
    get new_user_path 
    assert_response :success
    assert_select 'title', 'Sign up | Chess'
    assert_select 'div.form'
    assert_select 'div.error-messages', count: 0
  end 

  test "should not create user with invalid email" do 
    get new_user_path 
    assert_no_difference 'User.count' do 
      post users_path, params: { user: { name: @valid_user.name, 
                                         email: 'invalid',
                                         password: @valid_user.password,
                                         password_confirmation: @valid_user.password } }
    end
    assert_response :unprocessable_entity
    assert_select 'div.error-messages'
  end

  test "should not create user with non-matching passwords" do 
    get new_user_path 
    assert_no_difference 'User.count' do 
      post users_path, params: { user: { name: @valid_user.name, 
                                         email: @valid_user.email,
                                         password: 'foobar',
                                         password_confirmation: 'bazbar' } }
    end
    assert_response :unprocessable_entity
    assert_select 'div.error-messages'
  end

  test "should create a user after successful sign up" do 
    get new_user_path 
    assert_difference 'User.count', 1 do 
      post users_path, params: { user: { name: @valid_user.name, 
                                         email: @valid_user.email,
                                         password: 'foobar',
                                         password_confirmation: 'foobar' } }
    end
    @user = User.find_by(email: @valid_user.email)
    assert_redirected_to user_path(@user) 
    follow_redirect!
    assert_template 'users/show'
    assert_select 'title', "#{@valid_user.name} | Chess"
  end
end
