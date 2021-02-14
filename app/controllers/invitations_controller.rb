class InvitationsController < ApplicationController
  before_action :check_user_signed_in  
  def create
    invitation = Invitation.new(invitation_params)
    if invitation.save
      respond_to do |format|
        format.html { redirect_to '/', notice: 'Event added to your attended list' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to '/', alert: 'Event could not be added to your attended events' }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    invitation = Invitation.find_by(id: params[:id])
    if invitation.destroy
      respond_to do |format|
        format.html { redirect_to '/', notice: 'Event removed from your attended events' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to '/', alert: 'Error removing event from your attended events' }
        format.json { head :no_content }
      end
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:event_id, :user_id)
  end
end
