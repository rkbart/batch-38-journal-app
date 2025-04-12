require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)
    @task = tasks(:one)
		@task_today_1 = Task.create!(description: "Do something", due_date: Date.today, category: @category)
    @task_today_2 = Task.create!(description: "Another thing", due_date: Date.today, category: @category)
  end

  # User Story #1 - Create a Category
	test "should create category with user" do
    post categories_path, params: { category: { name: "Work" } }

		assert_equal "Work", Category.last.name
  end

	#User Story #2 - Edit and Update a Category
	test "should update category" do
		get edit_category_path(@category)
		patch category_path(@category), params: { category: { name: "Updated Category Name" } }
		
		@category.reload
		assert_equal "Updated Category Name", @category.name
	end

	#User Story #3 - View a Category
	test "should show category" do
		get category_path(@category)
		assert_response :success
	end

	#User Story #4 - Create  a Task in a Category
	test "should create task in category" do
		post category_tasks_path(@category), params: { task: { description: "Test Task", due_date: Date.today, category_id: @category.id } }
		assert_equal "Test Task", Task.last.description
	end

	#User Story #5 - Edit and Update a Task in a Category
	test "should update task in category" do
		get edit_category_task_path(@category, @task)
		patch category_task_path(@category, @task), params: { task: { description: "Updated Task" } }
		@task.reload
		assert_equal "Updated Task", @task.description
	end

	#User Story #6 - View a Task in a Category
	test "should show task in category" do
		get category_task_path(@category, @task)
		assert_response :success
	end

	#User Story #7 - Delete a Task in a Category
	test "should destroy task in category" do
		delete category_task_path(@category, @task)
		assert_response :redirect
	end

	#User Story #8 - View Tasks Today
	test "should show tasks today" do
		get categories_path

    assert_includes  @response.body, @task_today_1.description
    assert_includes  @response.body, @task_today_2.description
	end

	#User Story #9 - Create User
	test "should create user" do
		post user_registration_path, params: {
        user: {
          email: "newuser@example.com",
          password: "securepassword",
          password_confirmation: "securepassword"
        }
      }
			follow_redirect!
			assert_response :success
			assert_includes @response.body, "Welcome"
	end

	#User Story #10 - Log in User
	test "should log in user" do
		post user_session_path, params: {
    user: {
      email: @user.email,
      password: 'password' 
    }
  }

  follow_redirect!
  assert_includes @response.body, "Welcome"
	end
end
