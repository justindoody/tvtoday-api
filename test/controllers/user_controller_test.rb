require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "user login bad pass" do
    user = User.first
    assert_not user.authenticate("wrongpass")
  end

  test "user login good pass" do
    user = User.first
    assert user.authenticate("password")
  end

  test "user login good password" do
    post :create, user: {password: "password"}
    assert_redirected_to api_shows_path
  end

  test "user login bad password" do
    post :create, user: {password: "wrong"}
    assert_redirected_to login_path
  end

  test "user login page" do
    get :new
    assert_response :success
  end

end
