class InvitationsController < ApplicationController
  def index
  end
  
  def new
    @event_id = params[:id]
    @invitation = Invitation.new
    @events_options = upcoming_events_options
    @invitees_options = invitees_options
  end

  def create
    @invitation = current_user.sent_invitations.build(invitation_params)
    if @invitation.save
      invitee = User.find(params[:invitation][:invitee_id])
      event = Event.find(params[:invitation][:event_id])
      flash[:success] = "Invitation for #{event.name} sent to #{invitee.name}!"
      redirect_to new_invitation_path
    else
      @events_options = upcoming_events_options
      @invitees_options = invitees_options
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:event_id, :invitee_id)
  end

  def upcoming_events_options
    current_user.created_events.upcoming.map { |e| [e.name, e.id ] }
  end

  def invitees_options
    User.where.not(id: current_user.id).map { |u| [u.name, u.id ] }
  end
end
