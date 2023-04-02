# frozen_string_literal: true

module Api
  module V1
    class CxcController < ApplicationController
      def index
        @cxcs = Cxc.all

        render json: @cxcs
      end

      def find_cxc
        @cliente = Cliente.find(params[:cliente_id])
        @cxcs = @cliente.cxcs

        render json: @cxcs
      end
    end
  end
end
