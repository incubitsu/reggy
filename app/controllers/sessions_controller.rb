# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: sign_in_params[:email]).try(:authenticate, sign_in_params[:password])
    if @user
      sign_in(@user)
      redirect_to user_url, notice: t(:logged_in)
    else
      render 'new'
    end
  end

  def logout
    sign_out
    redirect_to root_url, notice: t(:logged_out)
  end

  private

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
