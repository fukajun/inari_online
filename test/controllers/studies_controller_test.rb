require 'test_helper'

class StudiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get studies_index_url
    assert_response :success
  end

end
