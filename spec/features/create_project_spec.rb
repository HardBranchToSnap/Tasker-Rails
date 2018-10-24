require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/new_project_form'

feature 'create new project' do
  let(:new_project_form) {NewProjectForm.new}
  let(:login_form) {LoginForm.new}
  let(:user) {FactoryBot.create(:user)}

  before do
    login_form.visit_page.login_as(user)
  end

  scenario 'create new project with valid data' do
    new_project_form.visit_page.fill_in_with(
      name: 'Testing project'
    ).submit

    expect(page).to have_content('Project created')
  end
end