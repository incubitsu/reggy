# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Forgot password features' do
  background 'as a registered user' do
    User.create!(email: 'person@example.com', password: 'password', password_confirmation: 'password')
  end
  I18n.available_locales.each do |_locale|
    scenario 'can request password reset' do
      visit('/')
      click_link(I18n.t(:login))

      click_link(I18n.t(:forgot_password))

      fill_in(I18n.t('simple_form.labels.defaults.email'), with: 'person@example.com')

      click_button I18n.t(:forgot_password)

      expect(page).to have_content I18n.t('forgot_passwords.email_sent')

      open_email('person@example.com')

      expect(current_email).to have_content 'Forgot your password?'

      current_email.click_link 'Reset Password'

      fill_in(I18n.t('simple_form.labels.defaults.password'), with: 'password2')
      fill_in(I18n.t('simple_form.labels.defaults.password_confirmation'), with: 'password2')

      click_button I18n.t(:reset_password)

      expect(current_path).to eql(new_session_path(locale: :en)) # Note: Emails are not localized
      expect(page).to have_content I18n.t('forgot_passwords.success')
    end
  end
end
