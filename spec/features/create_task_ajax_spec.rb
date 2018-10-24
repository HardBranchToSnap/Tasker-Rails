require 'rails_helper'
require_relative '../support/login_form'

feature 'Create task via ajax as autenticated user' do
  let(:user) { FactoryBot.create(:user)}
  let(:login_form) {LoginForm.new}

  before do
    login_form.visit_page.login_as(user)
  end

  scenario 'User create task', js: true do
    visit tasks_path

    click_on 'Create task'
    fill_in 'Title', with: 'Test task'
    click_on 'Add task'

    expect(current_path).to eq tasks_path
    within '.tasks' do
      expect(page).to have_content 'Test task'
    end
  end

  scenario 'User try to create unvalid tasks', js: true do
    visit tasks_path

    click_on 'Create task'
    click_on 'Add task'

    expect(current_path).to eq tasks_path
    expect(page).to have_content "Title can't be blank"
  end
end