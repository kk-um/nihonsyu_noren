require "test_helper"

class Users::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_comments_create_url
    assert_response :success
  end
end
