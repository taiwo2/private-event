class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, class_name: 'Event'

  def get_users_invited_to_event(id)
    Invitation.where(event_id: id)
  end

  def get_events_attended_by_user(id)
    Invitation.where(user_id: id)
  end
end
