require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "Invalid sign up information" do
    # go to signup route
    get signup_path

    # Assert that User.count doesn't change throughout this block
    assert_no_difference 'User.count' do
      post users_path, params: { 
        user: { 
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "foo"
        } 
      }
    end
    # assert that the users/new template was rendered
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
