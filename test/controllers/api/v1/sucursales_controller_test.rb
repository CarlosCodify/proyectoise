# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class SucursalesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @api_v1_sucursale = api_v1_sucursales(:one)
      end

      test 'should get index' do
        get api_v1_sucursales_url, as: :json
        assert_response :success
      end

      test 'should create api_v1_sucursale' do
        assert_difference('Api::V1::Sucursale.count') do
          post api_v1_sucursales_url, params: { api_v1_sucursale: {} }, as: :json
        end

        assert_response :created
      end

      test 'should show api_v1_sucursale' do
        get api_v1_sucursale_url(@api_v1_sucursale), as: :json
        assert_response :success
      end

      test 'should update api_v1_sucursale' do
        patch api_v1_sucursale_url(@api_v1_sucursale), params: { api_v1_sucursale: {} }, as: :json
        assert_response :success
      end

      test 'should destroy api_v1_sucursale' do
        assert_difference('Api::V1::Sucursale.count', -1) do
          delete api_v1_sucursale_url(@api_v1_sucursale), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
