# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  before(:each) do
    @sign_up_url = '/api/v1/auth'
    @sign_up_params = {
      email: 'stanley@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    }
    @sign_up_params2 = {
      email: 'test@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    }
  end

  context 'POST /api/v1/auth' do
    describe 'POST Request should create an account and return response 200' do
      before do
        post @sign_up_url, params: @sign_up_params
      end
      it ' 1. It should return a 200 status code' do
        expect(response).to have_http_status(:success)
      end
      it ' 2. It returns authentication header with right attributes (Access-Token)' do
        expect(response.headers['access-token']).to be_present
      end
      it ' 3. It returns authentication header with right attributes (Client)' do
        expect(response.headers['client']).to be_present
      end
      it ' 4. It returns authentication header with right attributes (Expiry)' do
        expect(response.headers['expiry']).to be_present
      end
      it ' 5. It returns authentication header with right attributes (UID)' do
        expect(response.headers['uid']).to be_present
      end
    end
    describe 'POST Request should update database User' do
      it ' 1. It should update the User Database' do
        expect { post @sign_up_url, params: @sign_up_params2 }.to change { User.count }.by(1)
      end
    end
    describe 'POST Request should return response 422' do
      it ' 1. It should return a 422 status code when registering with same Email' do
        post @sign_up_url, params: @sign_up_params1
        expect(response).to have_http_status(422)
      end
      it ' 2. It should return a 422 status code' do
        post @sign_up_url
        expect(response).to have_http_status(422)
      end
    end
  end

  # describe "POST /registrations" do
  #   it "works! (now write some real specs)" do
  #     get registrations_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
end
