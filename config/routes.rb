# frozen_string_literal: true

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :categories do
        resources :tasks
        get 'tasks/today', to: 'tasks#todays_tasks'
      end      
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
