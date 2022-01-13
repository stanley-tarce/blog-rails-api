# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @sign_up_url = '/api/v1/auth'
    @sign_in_url = '/api/v1/auth/sign_in'
    @sign_up_params = {
      email: @user.email,
      password: @user.password,
      password_confirmation: @user.password
    }
    @login_params = {
      email: @user.email,
      password: @user.password
    }
    (1..5).each do |_i|
      @user.categories.create(name: Faker::Book.genre)
    end
  end
  describe 'API Testing' do
    before(:each) do
      post @sign_in_url, params: @login_params
      @headers = {
        "access-token": response.headers['access-token'],
        "uid": response.headers['uid'],
        "client": response.headers['client'],
        "expiry": response.headers['expiry']
      }
    end
    it '1. Retrieve Total List of Category' do
      get '/api/v1/categories', headers: @headers, as: :json
      expect(response).to have_http_status(200)
    end
    it '2. Retrieve single data of Category' do
      get "/api/v1/categories/#{Category.last.id}", headers: @headers, as: :json
      expect(response).to have_http_status(200)
    end
    it '3. Create New Category' do
      post '/api/v1/categories', params: { category: { name: 'Stanley Tarce' } }, headers: @headers, as: :json
      expect(response).to have_http_status(200)
    end
    it '5. Update Category' do
      patch "/api/v1/categories/#{Category.last.id}", params: { category: { name: 'Category 2' } }, headers: @headers
      expect(response).to have_http_status(200)
    end
    it '6. Delete Category' do
      @user.categories.create(name: 'Get Category')
      id = Category.last.id
      delete "/api/v1/categories/#{id}", headers: @headers
      expect(response).to have_http_status(200)
    end
  end
end
