require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(username: "Example User", email: "user@example.com", is_artist: 1, 
                     password: "password", password_confirmation: "password")
  end

  test "should be valid?" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do 
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email format test" do
    valid_address = %w[user@example,com user_at_foo.org user.name@example.
                       foo@bar_baz.com foo@bar+baz.com]
    valid_address.each do |valid_address|
      @user.email = valid_address
      assert_not @user.valid?, "#{valid_address.inspect} should be invalid"
    end
  end

  test "email uniqueness test" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password validation test" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password minimum length test" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
