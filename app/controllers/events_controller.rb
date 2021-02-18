class EventsController < ApplicationController
  before_action :check_user_signed_in
  before_action :require_signed_in, only: %i[create new]
  before_action :attended_events, only: %i[index show]

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
    @user = User.find_by(id: session[:user_id])
    @event = @user.hosted_events.build(event_params)

    if @event.save
      redirect_to root_path, notice: 'Event posted'
    else
      redirect_to root_path, alert: 'Event could not be posted'
    end
  end

  private

  def attended_events
    return unless @user_signed_in

    @attended_events = Invitation.where(user_id: @user.id).pluck(:event_id)
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :date, :user_id)
  end

  def require_signed_in
    return if @user_signed_in

    redirect_to new_session_path, alert: 'You have to be signed in'
  end
end
