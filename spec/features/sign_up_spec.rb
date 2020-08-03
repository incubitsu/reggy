# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Sign up features' do
  I18n.available_locales.each do |locale|
    scenario 'can sign up' do
      visit(root_path(locale))
      click_link(I18n.t(:sign_up))

      fill_in(I18n.t('simple_form.labels.defaults.email'), with: 'person@example.com')
      fill_in(I18n.t('simple_form.labels.defaults.password'), with: 'password')
      fill_in(I18n.t('simple_form.labels.defaults.password_confirmation'), with: 'password')

      click_button 'Sign up'

      expect(current_path).to eql(user_path(locale))
      expect(page).to have_content(I18n.t(:profile))

      open_email('person@example.com')

      expect(current_email).to have_content 'Welcome to Reggy' # Note: Emails are not localized
    end
  end
end
