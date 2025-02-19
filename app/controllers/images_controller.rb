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
    # No need to initialize an Image object since Active Storage handles
  end

  def create
    # @image = @event.images.new
    if params[:image] && params[:image][:file].present?
      uploaded_files = params[:image][:file]
      if uploaded_files.any?
        uploaded_files.each do |file|
          @event.images.attach(file)
        end
        redirect_to event_images_path(@event), notice: 'Images uploaded' # remember that the image index belongs to an event 1d
      else
        flash.now[:alert] = 'No valid images selected'
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = 'Images upload failed' # or 'please select at least 1 image to upload'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    image = @event.images.find_by(id: params[:id])
    if image
      image.purge # .purge = (active storage delete function)
      flash[:notice] = 'Image deleted'
    else
      flash[:alert] = 'Image not found'
    end
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
