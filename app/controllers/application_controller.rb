class ApplicationController < ActionController::API
  include ActionController::Helpers
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  helper_method :login!, :current_user

  def login!
      session[:user_id] = @user.id
  end

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
