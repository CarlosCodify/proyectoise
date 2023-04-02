# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class ContactosControllerTest < ActionDispatch::IntegrationTest
      setup do
        @api_v1_contacto = api_v1_contactos(:one)
      end

      test 'should get index' do
        get api_v1_contactos_url, as: :json
        assert_response :success
      end

      test 'should create api_v1_contacto' do
        assert_difference('Api::V1::Contacto.count') do
          post api_v1_contactos_url, params: { api_v1_contacto: {} }, as: :json
        end

        assert_response :created
      end

      test 'should show api_v1_contacto' do
        get api_v1_contacto_url(@api_v1_contacto), as: :json
        assert_response :success
      end

      test 'should update api_v1_contacto' do
        patch api_v1_contacto_url(@api_v1_contacto), params: { api_v1_contacto: {} }, as: :json
        assert_response :success
      end

      test 'should destroy api_v1_contacto' do
        assert_difference('Api::V1::Contacto.count', -1) do
          delete api_v1_contacto_url(@api_v1_contacto), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
