require 'test_helper'

class Admin::OnlinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_onlines_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_onlines_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_onlines_edit_url
    assert_response :success
  end

end
