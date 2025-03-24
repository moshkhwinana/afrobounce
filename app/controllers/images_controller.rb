class ImagesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]
  before_action :event

  def index
    @images = @event.images || [] # Ensure @images is always an array
  end

  def show
    image_url = params[:image_url]

    if @event.images.include?(image_url)
      @image = image_url
    else
      flash[:alert] = "Image not found"
      redirect_to event_images_path(@event)
    end
  end

  def new
    # No need to initialize an Image object since Active Storage handles
  end

  def create
    if params[:images].present? # Ensure images were uploaded
      @event.images.attach(params[:images]) # Attach images to the event
      redirect_to event_images_path(@event), notice: "Images uploaded successfully!"
    else
      redirect_to event_images_path(@event), alert: "No images selected for upload."
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

  def event_params
    params.require(:event).permit(:name, :date, :cover_image, images: [])
  end
end
