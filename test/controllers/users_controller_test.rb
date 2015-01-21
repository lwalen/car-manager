require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get settings" do
    get :settings
    assert_response :success
  end

end
