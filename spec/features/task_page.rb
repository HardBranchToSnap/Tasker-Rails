require 'rails_helper'

feature 'task_page' do
  scenario 'task page' do
    task = FactoryBot.create(:task, title: 'Testing task')
    visit(task_path(task))

    expect(page).to have_content('Testing task')
  end
end