require 'test_helper'

class OnlinesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get onlines_show_url
    assert_response :success
  end

  test "should get edit" do
    get onlines_edit_url
    assert_response :success
  end

  test "should get update" do
    get onlines_update_url
    assert_response :success
  end

end
