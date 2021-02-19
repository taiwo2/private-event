class InvitationsController < ApplicationController
  before_action :check_user_signed_in

  def create
    invitation = Invitation.new(invitation_params)

    if invitation.save
      redirect_to root_path, notice: 'Event added to your attended list'
    else
      redirect_to root_path, alert: 'Event could not be added to your attended events'
    end
  end

  def destroy
    invitation = Invitation.find_by(id: params[:id])

    if invitation.destroy
      redirect_to root_path, notice: 'Event removed from your attended events'
    else
      redirect_to root_path, alert: 'Error removing event from your attended events'
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:attended_event_id, :attendee_id)
  end
end
