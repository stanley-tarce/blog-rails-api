# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  before_action :set_csrf_cookie
  private
  def set_csrf_cookie
    cookies.signed[:CSRF_COOKIE] = {value: form_authenticity_token, domain: 'herokuapp.com', expires: 3.days.from_now}
  end
end
