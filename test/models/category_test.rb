require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email: "test@example.com", password: "password123", password_confirmation: "password123")
    @category = Category.new(name: "Work", user: @user)
  end

  test "should be valid with valid attributes" do
    assert @category.valid? # runs validation
  end

  test "name should be present" do
    @category.name = ""
    assert_not @category.valid? # assert_not checks if invalid
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
    duplicate = Category.new(name: "Work", user: @user)
    assert_not duplicate.valid?
  end

  test "should belong to user" do
    assert_respond_to @category, :user # checks if category belongs to user
  end

  test "should have many tasks" do
    assert_respond_to @category, :tasks
  end

  test "should destroy associated tasks when destroyed" do
    @category.save
    @category.tasks.create(description: "Sample task")
    assert_difference("Task.count", -1) do # checks if task counts decreases by 1 if @category is deleted
      @category.destroy
    end
  end
end