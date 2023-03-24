require "test_helper"

class Api::V1::UsuariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_usuario = api_v1_usuarios(:one)
  end

  test "should get index" do
    get api_v1_usuarios_url, as: :json
    assert_response :success
  end

  test "should create api_v1_usuario" do
    assert_difference("Api::V1::Usuario.count") do
      post api_v1_usuarios_url, params: { api_v1_usuario: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_usuario" do
    get api_v1_usuario_url(@api_v1_usuario), as: :json
    assert_response :success
  end

  test "should update api_v1_usuario" do
    patch api_v1_usuario_url(@api_v1_usuario), params: { api_v1_usuario: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_usuario" do
    assert_difference("Api::V1::Usuario.count", -1) do
      delete api_v1_usuario_url(@api_v1_usuario), as: :json
    end

    assert_response :no_content
  end
end
