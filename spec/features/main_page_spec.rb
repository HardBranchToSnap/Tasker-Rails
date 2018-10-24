require 'rails_helper'

feature 'home page' do
  scenario 'welcome message' do
    visit root_path
    expect(page).to have_content('Hello, stranger')
  end
end