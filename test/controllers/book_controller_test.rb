require "test_helper"

class BookControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get book_edit_url
    assert_response :success
  end
end
