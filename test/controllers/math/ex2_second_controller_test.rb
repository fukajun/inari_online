require 'test_helper'

class Math::Ex2SecondControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get math_ex2_second_index_url
    assert_response :success
  end

end
