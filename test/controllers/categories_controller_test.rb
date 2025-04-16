require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)
  end

  # User Story #1 - Create a Category
  test "should create category" do
    post categories_path, params: { category: { name: "Work" } }

    assert_equal "Work", Category.last.name
  end

  # User Story #2 - Edit and Update a Category
  test "should update category" do
    get edit_category_path(@category)
    patch category_path(@category), params: { category: { name: "Updated Category Name" } }

    @category.reload
    assert_equal "Updated Category Name", @category.name
  end

  # User Story #3 - View a Category
  test "should show category" do
    get category_path(@category)
    assert_response :success
  end
end
