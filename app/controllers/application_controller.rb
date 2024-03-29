class ApplicationController < ActionController::Base

  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name, :email, :password, :password_confirmation,
                                                       :first_name, :last_name, :birth_day, :katakana_first_name, :katakana_last_name]) # rubocop:disable Layout/LineLength
  end
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end

