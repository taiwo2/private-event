class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :hosted_events, class_name: 'Event'
  has_many :events, foreign_key: :host_id, dependent: :destroy
  has_many :invitations
  has_many :attended_events, through: :invitations, source: :event

  def upcoming_events
    attended_events.where('event_date >= ?', Time.zone.now)
  end

  def previous_events
    attended_events.where('event_date < ?', Time.zone.now)
  end
end
