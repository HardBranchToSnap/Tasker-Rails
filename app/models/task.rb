class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true

  validates :title, presence: true
  validates :title, uniqueness: {
    scope: :user_id,
    message: 'You already have same name of task'
  }
  scope :published, -> { where(published: true) }
  scope :ofthisuser, -> { where(user: current_user)}

  enum status: [ :pending, :started, :finished ]
end
