require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
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
   assert_equal "Uncategorized", @user.categories.first.name
  end

  test "should destroy associated categories when user is destroyed" do
      category = categories(:one) # assume this belongs to user(:one)
      @user.destroy
    assert_not Category.exists?(category.id)
  end
end
