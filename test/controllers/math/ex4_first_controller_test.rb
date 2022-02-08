require 'test_helper'

class Math::Ex4FirstControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get math_ex4_first_index_url
    assert_response :success
  end

end
