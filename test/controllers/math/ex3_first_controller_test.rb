require 'test_helper'

class Math::Ex3FirstControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get math_ex3_first_index_url
    assert_response :success
  end

end
