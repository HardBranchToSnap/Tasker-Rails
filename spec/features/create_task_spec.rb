require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/new_task_form'

feature 'create new task' do
  let(:new_task_form) {NewTaskForm.new}
  let(:login_form) {LoginForm.new}
  let(:user) {FactoryBot.create(:user)}

  before do
    login_form.visit_page.login_as(user)
  end

  scenario 'create new task with valid data' do
    new_task_form.visit_page.fill_in_with(
      title: 'Test'
    ).submit

    expect(page).to have_content('Task added')
    #expect(Task.last.name).to eq('Test task')
  end

  scenario 'cannot create new task with invalid data' do
    new_task_form.visit_page.fill_in_with(title: '').submit

    expect(page).to have_content('can\'t be blank')
  end
end