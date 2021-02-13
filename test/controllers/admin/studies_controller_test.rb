require 'test_helper'

class Admin::StudiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_studies_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_studies_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_studies_edit_url
    assert_response :success
  end

end
