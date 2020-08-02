# frozen_string_literal: true

module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def current_user
    @current_user ||= begin
     User.find(session[:user_id]) if session[:user_id]
   end
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end
end
