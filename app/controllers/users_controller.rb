class UsersController < ApplicationController
    def show
      render json: {
          point: current_user.point
      }
    end
  end
  