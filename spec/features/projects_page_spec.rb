require 'rails_helper'
require_relative '../support/login_form'

feature 'projects_page' do
  let(:login_form) {LoginForm.new}
  let(:user) {FactoryBot.create(:user)}
  before {FactoryBot.create(:project, name: 'Test project', user: user)}

  before do
    login_form.visit_page.login_as(user)
  end

  scenario 'open projects page' do
    click_on 'Projects'
    expect(page).to have_content('Test project')
  end
end