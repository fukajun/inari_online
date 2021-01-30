require 'test_helper'

class Math::IaFirstControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get math_ia_first_index_url
    assert_response :success
  end

  test "should get show" do
    get math_ia_first_show_url
    assert_response :success
  end

end
