require 'rails_helper'
require_relative '../support/login_form'

feature 'Create task for project via ajax' do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:login_form) { LoginForm.new }

  before do
    login_form.visit_page.login_as(user)
  end

  scenario 'User create task for project', js: true do
    visit project_path(project)

    click_on 'Add task to project'
    fill_in 'Title', with: 'Test title for project'
    click_on 'Add task'

    expect(current_path).to eq project_path(project)
    expect(page).to have_content('Test title for project')
  end
end