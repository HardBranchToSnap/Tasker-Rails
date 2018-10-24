require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/new_project_form'

feature 'post new message in chat' do
  let(:new_project_form) {NewProjectForm.new}
  let(:login_form) {LoginForm.new}
  let(:user) {FactoryBot.create(:user)}
  let(:project) {FactoryBot.create(:project, user: user)}

  before do
    login_form.visit_page.login_as(user)
  end

  scenario 'enter project and post message in chat', js: true do
    visit project_path(project)
    fill_in 'Enter your message', with: 'Test message'
    click_on 'Send'

    expect(current_path).to eq project_path(project)
    within ".chat-box" do
      expect(page).to have_content('Test message')
    end
  end

end