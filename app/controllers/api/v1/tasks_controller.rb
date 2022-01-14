# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_api_v1_user!
      def todays_tasks
        @tasks = all_tasks.today
        if @tasks
          render json: @tasks, status: :ok
        else
          render json: { error: 'No tasks found' }, status: :not_found
        end
      end

      def index
        render json: all_tasks, status: 200
      end

      def show
        render json: single_task, status: 200
      end

      def create
        @task = all_tasks.new(task_params)
        if @task.save
          render json: @task, status: 200
        else
          render json: { errors: @task.errors.full_messages }, status: 422
        end
      end

      def update
        if single_task.update(task_params)
          render json: { message: 'Update Done' }, status: 200
        else
          render json: { errors: single_task.errors.full_messages }, status: 422
        end
      end

      def destroy
        if single_task.destroy
          render json: { message: 'Category successfully deleted' }
        else
          render json: { errors: single_task.errors.full_messages }, status: 422
        end
      end

      private

      def all_tasks
        tasks = current_api_v1_user.categories.find(params[:category_id]).tasks
      end

      def single_task
        task = current_api_v1_user.categories.find_by(id: params[:category_id]).tasks.find_by(id: params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :task_date)
      end
    end
  end
end
