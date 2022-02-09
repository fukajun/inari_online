require 'test_helper'

class Math::Ex4SecondControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get math_ex4_second_index_url
    assert_response :success
  end

end
