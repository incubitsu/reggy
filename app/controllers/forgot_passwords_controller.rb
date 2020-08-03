# frozen_string_literal: true

class ForgotPasswordsController < ApplicationController
  before_action :find_user, only: %i[edit update]
  def new; end

  def create
    user = User.find_by_email(forgot_password_create_params[:email])
    user&.send_password_reset_email
    redirect_to new_session_path, notice: t('forgot_passwords.email_sent')
  end

  def edit; end

  def update
    if @user.forgot_password_sent_at < 6.hour.ago
      redirect_to new_forgot_password_path, notice: t('forgot_passwords.expired')
    elsif @user.update(forgot_password_update_params)
      redirect_to new_session_path, notice: t('forgot_passwords.success')
    else
      render 'edit'
    end
  end

  private

  def find_user
    @user = User.find_by_forgot_password_token(params[:id])
  end

  def forgot_password_create_params
    params.require(:user).permit(:email)
  end

  def forgot_password_update_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
