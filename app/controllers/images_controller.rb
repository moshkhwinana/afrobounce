class ImagesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]
  before_action :event

  def index
    @images = @event.images
  end

  def show
    @image = @event.images.find(params[:id])
  end

  def new
    @image = @event.images.new
  end

  def create
    @image = @event.images.new
    if params[:image] && params[:image][:file]
      params[:image][:file].each do |file|
        @event.images.create(file: file) # .create = shortcut for .new + .save
      end
      redirect_to event_images(@event), notice: 'Images uploaded'
    else
      flash.now[:alert] = 'Images upload failed'
      render :new
    end
  end

  def destroy
    @image = @event.images.find(params[:id])
    @image.destroy
    redirect_to event_images_path, status: :see_other
  end

  private

  def event
    @event = Event.find(params[:event_id])
  end

  def image_params
    params.require(:image).permit(:file)
  end
end
