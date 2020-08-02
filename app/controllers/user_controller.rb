# frozen_string_literal: true

class UserController < ApplicationController
  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to user_url, notice: 'saved'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
