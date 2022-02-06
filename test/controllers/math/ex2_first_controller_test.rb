require 'test_helper'

class Math::Ex2FirstControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get math_ex2_first_index_url
    assert_response :success
  end

end
