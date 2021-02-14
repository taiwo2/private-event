class EventsController < ApplicationController
  before_action :check_user_signed_in
  before_action :require_signed_in, only: %i[create new]
  before_action :attended_events, only: %i[index show]

  def index
    @events = Event.all.order('date')
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
      respond_to do |format|
        format.html { redirect_to '/', notice: 'Event posted!' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        puts @event.errors.full_messages
        format.html { redirect_to '/', alert: 'Event could not be posted...' }
        format.json { head :no_content }
      end
    end
  end

  private

  def attended_events
    if @user_signed_in
      @user = User.find_by(id: session[:user_id])

    elsif @user
      @attended_events = Invitation.where(user_id: @user.id).pluck(:event_id)
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :date, :user_id)
  end

  def check_user_signed_in
    super
  end

  def require_signed_in
    if !@user_signed_in

      respond_to do { |format| format.html { redirect_to '/sessions/new', alert: 'You have to be signed in!' } }
      end
    end
  end
end
