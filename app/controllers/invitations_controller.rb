class InvitationsController < ApplicationController
  def index
  end
  
  def new
    @invitation = Invitation.new
    @events_options = current_user.created_events.upcoming.map { |e| [e.name, e.id ] }
    @invitees_options = User.where.not(id: current_user.id).map { |u| [u.name, u.id ]}
  end

  def create
    @invitation = current_user.sent_invitations.build(invitation_params)
    if @invitation.save
      invitee = User.find(params[:invitation][:invitee_id])
      event = Event.find(params[:invitation][:event_id])
      flash[:success] = "Invitation for #{event.name} sent to #{invitee.name}!"
      redirect_to new_invitation_path
    else
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:event_id, :invitee_id)
  end
end
