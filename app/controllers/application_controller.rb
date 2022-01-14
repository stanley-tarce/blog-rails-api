# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  before_action :set_csrf_cookie
  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = {value: form_authenticity_token, domain: '.herokuapp.com', expires: 5.days.from_now, same_site: "None", secure: true}
  end
end
