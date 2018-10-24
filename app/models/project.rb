class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, presence: true
end
