require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @category = categories(:one)
    @task = tasks(:one)
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
    @task.valid?
    assert_equal Date.today, @task.due_date
  end

  test "should not override due_date if already set" do
    tomorrow = Date.today + 1
    @task.due_date = tomorrow
    @task.valid?
    assert_equal tomorrow, @task.due_date
  end
end
