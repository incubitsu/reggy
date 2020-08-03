# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Forgot password features' do
  background 'as a registered user' do
    User.create!(email: 'person@example.com', password: 'password', password_confirmation: 'password')
  end

  scenario 'can request password reset' do
    visit('/')
    click_link('Login')

    click_link('Forgot password?')

    fill_in('Email', with: 'person@example.com')
    click_button 'Forgot Password'

    expect(page).to have_content 'Email sent with password reset instructions'

    open_email('person@example.com')

    expect(current_email).to have_content 'Forgot your password?'

    current_email.click_link 'Reset Password'

    fill_in('Password', with: 'password2')
    fill_in('Password confirmation', with: 'password2')

    click_button 'Reset Password'

    expect(current_path).to eql('/sessions/new')
    expect(page).to have_content 'Password has been reset'
  end
end
