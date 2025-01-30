class EventsController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show] # categories of images from the events
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    # if @event.save
    #   puts "Event saved successfully: #{@event.inspect}"
    #   redirect_to events_path
    # else
    #   puts "Failed to save: #{@event.errors.full_messages}"
    # end
    if @event.save
      redirect_to events_path, notice: 'Event created'
    else
      flash.now[:alert] = 'Event failed to be created'
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to events_path
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, status: :see_other
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :cover_image)
  end
end
