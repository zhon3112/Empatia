require "test_helper"

class MyPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_posts_index_url
    assert_response :success
  end
end
