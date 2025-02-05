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
    if params[:image] && params[:image][:file].present?
      params[:image][:file].each do |file|
        @event.images.create!.tap do |image| # .tap ensures the image is saved before attaching files - .create = shortcut for .new + .save
          image.file.attach(file) # correct way to attach files in Active Storage
        end
      end
      redirect_to event_images_path(@event), notice: 'Images uploaded'
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
