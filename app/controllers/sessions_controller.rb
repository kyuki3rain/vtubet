class SessionsController < ApplicationController
  require "pry"
  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      login!
      payload = { logged_in: true }
    else
      payload = { status: 401, errors: ['メールアドレスまたはパスワードが正しくありません。'] }
    end

    render json: payload
  end

  def logout
    reset_session
    render json: { status: 200, logged_out: true }
  end

  def logged_in?
    if current_user
        render json: { logged_in: true, user: current_user.email }
    else
        render json: { logged_in: false, message: 'ユーザーが存在しません' }
    end
  end

  def test
    session[:user_id] = 1
    binding.pry
    render json: {}
  end
end
