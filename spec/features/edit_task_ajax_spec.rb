require 'rails_helper'
require_relative '../support/login_form'

feature 'Edit task via ajax ' do
  let(:user) { FactoryBot.create(:user)}
  let(:login_form) {LoginForm.new}
  let(:task) {FactoryBot.create(:task, user: user}

  before do
    login_form.visit_page.login_as(user)
  end

  scenario 'Author trys to edit self task' do

    visit tasks_path
    click_on 'Edit'
    fill_in 'Title', with: 'Edited title'
    click_on 'Save'

    expect(page).not_to have_content(task.title)
    expect(page).to have_content('Edited title')
  end
end