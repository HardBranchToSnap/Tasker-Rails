require 'rails_helper'
require_relative '../support/login_form'

feature 'Open project tasks' do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, user: user) }
  let(:login_form) { LoginForm.new }

  before do
    login_form.visit_page.login_as(user)
  end

  scenario 'User can edit project', js: true do
    visit project_path(project)
    click_on 'Edit'
    fill_in 'edit_name_field', with: 'Edited project'
    click_on 'Save'

    expect(current_path).to eq project_path(project)
    expect(page).to have_content('Edited project')
  end
end