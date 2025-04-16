require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email: "test@example.com", password: "password123", password_confirmation: "password123")
    @category = Category.create(name: "Home", user: @user)
    @task = Task.new(description: "Clean room", category: @category)
  end

  test "should be valid with valid attributes" do
    assert @task.valid?
  end

  test "description should be present" do
    @task.description = ""
    assert_not @task.valid?
  end

  test "description should be at least 2 characters" do
    @task.description = "A"
    assert_not @task.valid?
  end

  test "description should not exceed 30 characters" do
    @task.description = "A" * 31
    assert_not @task.valid?
  end

  test "should belong to category" do
    assert_respond_to @task, :category
  end

  test "should set default due_date if not provided" do
    @task.due_date = nil
    @task.valid?  # triggers before_validation
    assert_equal Date.today, @task.due_date
  end

  test "should not override due_date if already set" do
    tomorrow = Date.today + 1
    @task.due_date = tomorrow
    @task.valid?
    assert_equal tomorrow, @task.due_date
  end
end
