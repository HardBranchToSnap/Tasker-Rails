class NewTaskForm
  include Capybara::DSL

  def visit_page
    visit '/'
    click_on('Create task')
    return self
  end

  def fill_in_with(params = {})
    fill_in('Title', with: params.fetch(:title, 'Test task'))
    fill_in('Description', with: params.fetch(:description, 'Here is a test description'))
    select('Pending', from: 'Status')
    return self
  end

  def submit
    click_on('Add task')
    return self
  end
end