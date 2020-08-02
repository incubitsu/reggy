# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Home features' do
  scenario 'opens home page' do
    visit('/')
    expect(page).to have_content('Welcome to Reggy')
  end
end
