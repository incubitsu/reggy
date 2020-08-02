# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def welcome_mail(user)
    mail(
      to: user.email,
      subject: 'Welcome to Reggy!'
    )
  end
end
