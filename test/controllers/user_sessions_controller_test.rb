require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  test "should get login page" do
    get :new
    assert_response :success
  end

  test "should login" do
    post :new, user_session: { username: 'user1', password: 'asdf' }

    assert_response :success
  end
end
