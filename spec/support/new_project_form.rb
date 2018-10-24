class NewProjectForm
  include Capybara::DSL

  def visit_page
    visit '/'
    click_on('New project')
    return self
  end

  def fill_in_with(params = {})
    fill_in('Name', with: params.fetch(:name, 'Test project'))
    fill_in('Description', with: params.fetch(:description, 'Here is a test description'))
    return self
  end

  def submit
    click_on('Create project')
    return self
  end
end