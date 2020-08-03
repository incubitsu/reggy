# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Sign in features' do
  background 'as a registered user' do
    User.create!(email: 'person@example.com', password: 'password', password_confirmation: 'password')
  end

  I18n.available_locales.each do |locale|
    scenario 'can sign in and sign out' do
      visit(root_path(locale))
      click_link(I18n.t(:login))

      fill_in(I18n.t('simple_form.labels.defaults.email'), with: 'person@example.com')
      fill_in(I18n.t('simple_form.labels.defaults.password'), with: 'password')

      click_button I18n.t(:login)

      expect(current_path).to eql(user_path(locale))
      expect(page).to have_content(I18n.t(:profile))
      expect(page).to have_content(I18n.t('sessions.logged_in'))

      click_link I18n.t(:sign_out)

      expect(current_path).to eql(root_path(locale))
      expect(page).to have_content(I18n.t('sessions.logged_out'))
    end
  end
end
