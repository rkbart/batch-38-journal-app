require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @category = categories(:one)
  end

  test "should be valid with valid attributes" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = ""
    assert_not @category.valid?
  end

  test "name should be at least 2 characters" do
    @category.name = "A"
    assert_not @category.valid?
  end

  test "name should not be longer than 30 characters" do
    @category.name = "A" * 31
    assert_not @category.valid?
  end

  test "name should be unique per user" do
    @category.save
    duplicate = Category.new(name: "Uncategorized", user: @user)
    assert_not duplicate.valid?
  end

  test "should belong to user" do
    assert_respond_to @category, :user
  end

  test "should have many tasks" do
    assert_respond_to @category, :tasks
  end

  test "should destroy associated tasks when destroyed" do
    task = tasks(:one) # assume this belongs to categories(:one)
      @category.destroy
    assert_not Task.exists?(task.id)
  end
end
