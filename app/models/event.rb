class Event < ApplicationRecord
  belongs_to :host, foreign_key: 'user_id', class_name: 'User'
  has_many :invitations
  has_many :attendees, through: :invitations, source: :user
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true
  scope :past, -> { where('date < ?', DateTime.now) }
  scope :future, -> { where('date >= ?', DateTime.now) }
end
