class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :hosted_events, class_name: 'Event'
  has_many :invitations
  has_many :attended_events, through: :invitations, source: :event
end
