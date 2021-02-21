class EventsController < ApplicationController
  before_action :authenticate_user, only: %i[create new]

  def index
    @past_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      EventAttendance.create! attendee: current_user, attended_event: @event
      redirect_to root_path, notice: 'Event posted'
    else
      redirect_to root_path, alert: 'Event could not be posted'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :event_date)
  end
end
