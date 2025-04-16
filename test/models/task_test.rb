require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @category = categories(:one)
    @task = @category.tasks.build(description: "Test Task", due_date: Date.today)
  end

  test "description should be present" do
    @task.description = ""
    assert_not @task.valid?
  end

  test "description should have a length between 2 and 30 characters" do
    @task.description = "A"
    assert_not @task.valid?

    @task.description = "A" * 31
    assert_not @task.valid?

    @task.description = "Do Homework"
    assert @task.valid?
  end
  test "should belong to a category" do
    assert_equal @category, @task.category
  end
end
