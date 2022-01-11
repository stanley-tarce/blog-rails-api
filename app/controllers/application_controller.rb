# frozen_string_literal: true

class ApplicationController < ActionController::API\
  protect_from_forgery with: :null_session
  include DeviseTokenAuth::Concerns::SetUserByToken
end
