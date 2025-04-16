require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should have many categories" do
    assert_respond_to @user, :categories # checks if @user has categories
  end

  test "should have many tasks through categories" do
    assert_respond_to @user, :tasks
  end

  test "should create a default category after creation" do
    @user.save
    assert_equal 1, @user.categories.count
    assert_equal "Uncategorized", @user.categories.first.name
  end

  test "should destroy associated categories when user is destroyed" do
    @user.save
    @user.categories.create(name: "Work")
    assert_difference("Category.count", -2) do # checks if categories ae deleted
      @user.destroy
    end
  end
end
