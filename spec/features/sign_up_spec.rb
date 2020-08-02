# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Sign up features' do
  scenario 'can sign up' do
    visit('/')
    click_link('Sign up')

    fill_in('Email', with: 'person@example.com')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')

    click_button 'Sign up'

    expect(current_path).to eql('/user')
    expect(page).to have_content('Profile')

    open_email('person@example.com')

    expect(current_email).to have_content 'Welcome to Reggy'
  end
end
