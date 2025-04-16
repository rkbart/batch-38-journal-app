require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should create user with valid attributes" do
    user = User.new(email: "test@example.com", password: "password")
    assert user.save
  end
end
