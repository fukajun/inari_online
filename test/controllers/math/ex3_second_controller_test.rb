require 'test_helper'

class Math::Ex3SecondControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get math_ex3_second_index_url
    assert_response :success
  end

end
