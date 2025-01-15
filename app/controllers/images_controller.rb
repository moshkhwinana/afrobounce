class ImagesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]

  def index
    @event = Event.find(params[:event_id])
    @images = @event.images
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end
end
