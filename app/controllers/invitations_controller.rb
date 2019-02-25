class InvitationsController < ApplicationController
  def index
    redirect_to new_invitation_path if request.original_url == invitations_url
    @invitations = current_user.received_invitations.pending.includes(:inviter, :event)
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
      invitee = @invitation.invitee
      event = @invitation.event
      flash[:success] = "Invitation for #{event.name} sent to #{invitee.name}!"
      redirect_to new_invitation_path
    else
      @events_options = upcoming_events_options
      @invitees_options = invitees_options
      render :new
    end
  end

  def edit  
    @invitation = Invitation.find(params[:id])
    unless @invitation.pending?
      flash[:error] = "This invitation has already been responded to."
      redirect_to pending_path
    end
    @event = @invitation.event
    @inviter = @invitation.inviter
  end

  def update
    invitation = Invitation.find(params[:id])
    invitation.update_attribute(:accepted, "yes")
    invitation.invitee.add_event(invitation.event)
    flash[:success] = "Invitation accepted!"
    redirect_to invitation.event
  end

  def destroy
    invitation = Invitation.find(params[:id])
    invitation.destroy
    flash[:success] = "Invitation declined."
    redirect_to pending_path
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
