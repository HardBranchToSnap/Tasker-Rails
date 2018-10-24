class Message < ApplicationRecord
  belongs_to :project
  belongs_to :user

  scope :latest, -> { order(id: :desc)}
end
