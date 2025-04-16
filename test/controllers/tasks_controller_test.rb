require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)
    @task = tasks(:one)
    @task2 = tasks(:two)
  end

  # User Story #4 - Create a Task in a Category
  test "should create task in category" do
    post category_tasks_path(@category), params: {
      task: {
        description: "Test Task",
        due_date: Date.today
      }
    }

    assert_equal "Test Task", Task.last.description
  end

  # User Story #5 - Edit and Update a Task in a Category
  test "should update task in category" do
    get edit_category_task_path(@category, @task)
    patch category_task_path(@category, @task), params: {
      task: { description: "Updated Task" }
    }

    @task.reload
    assert_equal "Updated Task", @task.description
  end

  # User Story #6 - View a Task in a Category
  test "should show task in category" do
    get category_task_path(@category, @task)
    assert_response :success
  end

  # User Story #7 - Delete a Task in a Category
  test "should delete task in category" do
    assert_difference("Task.count", -1) do
      delete category_task_path(@category, @task)
    end
    assert_response :redirect
  end

  # User Story #8 - View Tasks Due Today
  test "should show tasks today" do
    get tasks_path

    assert_includes @response.body, @task.description
    assert_includes @response.body, @task2.description
  end
end
