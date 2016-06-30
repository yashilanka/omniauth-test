require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get finish_signup" do
    get :finish_signup
    assert_response :success
  end

end
