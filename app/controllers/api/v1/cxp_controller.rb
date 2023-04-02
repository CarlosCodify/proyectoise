# frozen_string_literal: true

module Api
  module V1
    class CxpController < ApplicationController
      def index
        @cxps = Cxp.all

        render json: @cxps
      end

      def find_cxp
        @proveedor = Proveedor.find(params[:proveedor_id])
        @cxcs = @proveedor.cxps

        render json: @cxcs
      end
    end
  end
end
