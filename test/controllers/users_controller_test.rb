require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # User Story #9 - Create User
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

  # User Story #10 - Log in User
  test "should log in user" do
    user = users(:one)

    post user_session_path, params: {
      user: {
        email: user.email,
        password: "password"
      }
    }

    follow_redirect!
    assert_includes @response.body, "Welcome"
  end
end
