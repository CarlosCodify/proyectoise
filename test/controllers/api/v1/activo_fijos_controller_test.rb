require "test_helper"

class Api::V1::ActivoFijosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_activo_fijo = api_v1_activo_fijos(:one)
  end

  test "should get index" do
    get api_v1_activo_fijos_url, as: :json
    assert_response :success
  end

  test "should create api_v1_activo_fijo" do
    assert_difference("Api::V1::ActivoFijo.count") do
      post api_v1_activo_fijos_url, params: { api_v1_activo_fijo: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_activo_fijo" do
    get api_v1_activo_fijo_url(@api_v1_activo_fijo), as: :json
    assert_response :success
  end

  test "should update api_v1_activo_fijo" do
    patch api_v1_activo_fijo_url(@api_v1_activo_fijo), params: { api_v1_activo_fijo: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_activo_fijo" do
    assert_difference("Api::V1::ActivoFijo.count", -1) do
      delete api_v1_activo_fijo_url(@api_v1_activo_fijo), as: :json
    end

    assert_response :no_content
  end
end
