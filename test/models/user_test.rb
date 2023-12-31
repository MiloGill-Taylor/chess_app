require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'milo', email: 'milo@gill-taylor.com', 
                     password: 'password', password_confirmation: 'password')
  end 

  test "should be valid" do 
    assert @user.valid?
  end 

  test "name validations" do 
    @user.name = '   '
    assert_not @user.valid?
    @user.name = 'a'*21
    assert_not @user.valid?
  end 

  test "email should be present" do 
    @user.email = "     "
    assert_not @user.valid?
  end 

  test "email cannot be duplicate" do 
    duplicate_user = @user.dup 

    @user.save 
    assert_not duplicate_user.valid? 
  end 

  test "email should not be too long" do 
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end 

  test "email validation should accept valid addresses" do 
    valid_addresses = %w[
      user@example.com USER@foo.COM A_US-ER@foo.bar.org 
      first.last@foo.jp alice+bob@baz.cn
    ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address 
      assert @user.valid?, "#{valid_address.inspect} should be valid" 
      # second arguement is a message displayed on failure
    end 
  end 

  test "email validation should reject invalid addresses" do 
    invalid_addresses = %w[
      user@example,com user_at_foo.org user.name@example. 
      foo@bar_baz.com foo@bar+baz.com foo@bar..com
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end 

  end 

  test "saved email should be lowercase" do  
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email 
    @user.save 
    assert_equal mixed_case_email.downcase , @user.reload.email 
  end 

  test "password should have a minimum length" do 
    assert @user.valid? 
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid? 
  end 

  test "password should be present (nonblank)" do 
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end 
end
