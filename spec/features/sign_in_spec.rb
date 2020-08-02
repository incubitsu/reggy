# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Sign in features' do
  background 'as a registered user' do
    User.create!(email: 'person@example.com', password: 'password', password_confirmation: 'password')
  end

  scenario 'can sign in and sign out' do
    visit('/')
    click_link('Login')

    fill_in('Email', with: 'person@example.com')
    fill_in('Password', with: 'password')

    click_button 'Login'

    expect(current_path).to eql('/user')
    expect(page).to have_content('Profile')
    expect(page).to have_content('Successfully logged in')

    click_link 'Sign out'

    expect(current_path).to eql('/')
    expect(page).to have_content('Successfully logged out')
  end
end
