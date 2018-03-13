require 'test_helper'

class JoinsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get joins_index_url
    assert_response :success
  end

  test "should get show" do
    get joins_show_url
    assert_response :success
  end

  test "should get destroy" do
    get joins_destroy_url
    assert_response :success
  end

end
