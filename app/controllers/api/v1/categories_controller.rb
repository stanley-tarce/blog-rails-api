# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authenticate_api_v1_user!
      def index
        render json: categories, status: 200
      end

      def show
        render json: single_category, status: 200
      end

      def create
        @category = current_api_v1_user.categories.new(category_params)
        if @category.save
          render json: @category, status: 200
        else
          render json: { errors: @category.errors.full_messages }, status: 422
        end
      end

      def update
        if single_category.update(category_params)
          # render json: CategorySerializer.new(category).serialized_json
          render json: { message: 'Update Successful' }, status: 200
        else
          render json: { errors: category.errors.full_messages }, status: 422
        end
      end

      def destroy
        if single_category.destroy
          render json: { message: 'Category successfully deleted' }
        else
          render json: { errors: category.errors.full_messages }, status: 422
        end
      end
  

      private

      def categories
        categories = current_api_v1_user.categories
      end

      def single_category
        category = current_api_v1_user.categories.find_by(id: params[:id])
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
