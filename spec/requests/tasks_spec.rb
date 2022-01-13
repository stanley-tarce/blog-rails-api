# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
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
    FactoryBot.create(:category, user: @user)
    (1..5).each do |i|
      @user.categories.first.tasks.create(title: "Task #{i} ", description: Faker::Quote.famous_last_words,
                                          task_date: "2021-12-#{i + 5}")
    end
  end

  describe 'API Tests of Task' do
    before(:each) do
      post @sign_in_url, params: @login_params
      @headers = {
        'access-token': response.headers['access-token'],
        'client': response.headers['client'],
        'expiry': response.headers['expiry'],
        'uid': response.headers['uid']
      }
    end
    it ' 1. Should get all Tasks' do
      get "/api/v1/categories/#{@user.categories.first.id}/tasks", headers: @headers, as: :json
      expect(response).to have_http_status(200)
    end
    it '2. Should get a Task' do
      get "/api/v1/categories/#{@user.categories.first.id}/tasks/#{@user.categories.first.tasks.first.id}",
          headers: @headers, as: :json
      expect(response).to have_http_status(200)
    end
    it '3. Should create a Task' do
      post "/api/v1/categories/#{@user.categories.first.id}/tasks",
           params: { task: { title: 'Stanley Tarce', description: 'Test', task_date: '2021-12-7' } }, headers: @headers, as: :json
      expect(response).to have_http_status(:success)
    end
    it '4. Should update a Task' do
      patch "/api/v1/categories/#{@user.categories.first.id}/tasks/#{@user.categories.first.tasks.last.id}",
            headers: @headers, params: { title: 'Task 991', description: 'LoremIpsums', task_date_string: '2021-12-6' }, as: :json
    end
    it '5. Should delete a Task' do
      delete "/api/v1/categories/#{@user.categories.first.id}/tasks/#{@user.categories.first.tasks.last.id}",
             headers: @headers, as: :json
      expect(response).to have_http_status(:success)
    end
    it '6. Should get all Tasks for the Day' do
      get "/api/v1/categories/#{@user.categories.first.id}/tasks/today", headers: @headers, as: :json
      expect(response).to have_http_status(200)
    end
  end
end
