require "test_helper"

class Api::V1::CreditosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_credito = api_v1_creditos(:one)
  end

  test "should get index" do
    get api_v1_creditos_url, as: :json
    assert_response :success
  end

  test "should create api_v1_credito" do
    assert_difference("Api::V1::Credito.count") do
      post api_v1_creditos_url, params: { api_v1_credito: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_credito" do
    get api_v1_credito_url(@api_v1_credito), as: :json
    assert_response :success
  end

  test "should update api_v1_credito" do
    patch api_v1_credito_url(@api_v1_credito), params: { api_v1_credito: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_credito" do
    assert_difference("Api::V1::Credito.count", -1) do
      delete api_v1_credito_url(@api_v1_credito), as: :json
    end

    assert_response :no_content
  end
end
