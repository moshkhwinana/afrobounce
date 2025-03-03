class ImagesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]
  before_action :event

  def index
    @images = @event.images
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
    uploaded_files = params[:images] # Multiple file upload

    if uploaded_files.present?
      uploaded_urls = uploaded_files.map do |file|
        Cloudinary::Uploader.upload(file)["secure_url"]
      end

      @event.update(images: (@event.images || []) + uploaded_urls)

      flash[:notice] = "Images uploaded successfully!"
      redirect_to event_images_path(@event)
    else
      flash[:alert] = "No images selected"
      render :new
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
    @event = Event.find_by(id: params[:event_id])

    unless @event
      flash[:alert] = "Event not found"
      redirect_to events_path
    end
  end
end
