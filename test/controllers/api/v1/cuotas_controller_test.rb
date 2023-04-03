require "test_helper"

class Api::V1::CuotasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_cuotas_index_url
    assert_response :success
  end
end
