# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class CuentaBancosControllerTest < ActionDispatch::IntegrationTest
      setup do
        @api_v1_cuenta_banco = api_v1_cuenta_bancos(:one)
      end

      test 'should get index' do
        get api_v1_cuenta_bancos_url, as: :json
        assert_response :success
      end

      test 'should create api_v1_cuenta_banco' do
        assert_difference('Api::V1::CuentaBanco.count') do
          post api_v1_cuenta_bancos_url, params: { api_v1_cuenta_banco: {} }, as: :json
        end

        assert_response :created
      end

      test 'should show api_v1_cuenta_banco' do
        get api_v1_cuenta_banco_url(@api_v1_cuenta_banco), as: :json
        assert_response :success
      end

      test 'should update api_v1_cuenta_banco' do
        patch api_v1_cuenta_banco_url(@api_v1_cuenta_banco), params: { api_v1_cuenta_banco: {} }, as: :json
        assert_response :success
      end

      test 'should destroy api_v1_cuenta_banco' do
        assert_difference('Api::V1::CuentaBanco.count', -1) do
          delete api_v1_cuenta_banco_url(@api_v1_cuenta_banco), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
