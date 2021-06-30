require 'test_helper'

class Admin::CalendarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_calendars_index_url
    assert_response :success
  end

end
