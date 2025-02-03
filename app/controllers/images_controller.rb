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
    @images = @event.images.new
  end

  def create
    @images = @event.images.new(image_params)
    if @images.save
      redirect_ to event_images_path, notice: 'Images created'
    else
      flash.now[:alert] = 'Images creation failed'
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
