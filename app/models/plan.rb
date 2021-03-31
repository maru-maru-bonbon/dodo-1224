class Plan < ApplicationRecord
  belongs_to :user
  has_many :participants
  has_many :participant_users, through: :participants, source: :user

  has_one_attached :image

end
