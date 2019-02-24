class EventsController < ApplicationController
  def index
    case request.original_url
    when events_url
      @title = "My Events"
      @events = current_user.created_events
    when upcoming_url
      @title = "Upcoming Events"
      @events = current_user.upcoming_events
    when attended_url
      @title = "Past Events"
      @events = current_user.past_events
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      @event.attendees << current_user
      flash[:success] = "Event created successfully."
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :location, :description)
  end
end
