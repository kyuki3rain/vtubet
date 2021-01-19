class RegistrationsController < ApplicationController
  def signup
    @user = User.new(user_params)

    if @user.save!
      login!
      payload = { created: true }
    else
      payload = { status: 500 }
    end

    render json: payload
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
