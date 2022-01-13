# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @sign_in_url = '/api/v1/auth/sign_in'
    @sign_out_url = '/api/v1/auth/sign_out'
    @sign_up_url = '/api/v1/auth'
    @login_params = {
      email: @user.email,
      password: @user.password
    }
    @sign_up_params = {
      email: @user.email,
      password: @user.password,
      password_confirmation: @user.password
    }
    post @sign_up_url, params: @sign_up_params
  end
  context 'POST /api/v1/auth/sign_in' do
    describe 'Sign In Success Responses and Headers' do
      before do
        post @sign_in_url, params: @login_params, as: :json
      end
      it '1. It returns a success response' do
        expect(response).to have_http_status(:success)
      end
      it '2. It returns authentication header for the user to user (Access-Token)' do
        expect(response.headers['access-token']).to be_present
      end
      it '3. It returns authentication header for the user to user (Client)' do
        expect(response.headers['client']).to be_present
      end
      it '4. It returns authentication header for the user to user (Expiry)' do
        expect(response.headers['expiry']).to be_present
      end
      it '5. It returns authentication header for the user to user (UID)' do
        expect(response.headers['uid']).to be_present
      end
    end
    describe 'Sign In Failed Responses' do
      before(:each) do
        post @sign_in_url
      end
      it '1. It returns a failure response' do
        expect(response).to have_http_status(:unauthorized)
      end
      it '2. It returns a failure message' do
        expect(response.body['errors']).to be_present
      end
    end
    describe 'Sign Out Success Responses' do
      before(:each) do
        post @sign_in_url, params: @login_params, as: :json
        @headers = {
          'access-token': response.headers['access-token'],
          'client': response.headers['client'],
          'uid': response.headers['uid'],
          'expiry': response.headers['expiry']
        }
      end
      it '1. It returns a success response' do
        delete @sign_out_url, headers: @headers, as: :json
        expect(response).to have_http_status(:success)
      end
      it '2. It returns a success message' do
        delete @sign_out_url, headers: @headers, as: :json
        expect(response.body).to be_present
      end
    end
  end
end
