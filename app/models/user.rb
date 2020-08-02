# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_length_of :username, minimum: 5, on: :update, if: :will_save_change_to_username?
  validates :email, presence: true, uniqueness: true
  validates_length_of :password, minimum: 8

  before_validation :normalize_email, on: :create
  before_create :set_default_username

  protected

  def normalize_email
    self.email = email&.downcase
  end

  def set_default_username
    self.username = email.split('@').first
  end
end
