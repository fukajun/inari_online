require 'test_helper'

class Math::Ex1SecondControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get math_ex1_second_index_url
    assert_response :success
  end

end
