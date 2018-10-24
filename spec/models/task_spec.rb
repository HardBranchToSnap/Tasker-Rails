require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_uniqueness_of(:title).scoped_to(:user_id).with_message('You already have same name of task')}
    it {should validate_presence_of(:user)}
    it {should belong_to(:user)}
  end
end