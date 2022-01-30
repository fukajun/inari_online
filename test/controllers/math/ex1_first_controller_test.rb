require 'test_helper'

class Math::Ex1FirstControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get math_ex1_first_index_url
    assert_response :success
  end

end
