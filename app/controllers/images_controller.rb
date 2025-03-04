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
    uploaded_files = params[:images] # Get multiple files

    if uploaded_files.present?
      uploaded_urls = uploaded_files.map do |file|
        # Upload to Cloudinary with folder structure
        Cloudinary::Uploader.upload(file, folder: "afrobounce/events/#{@event.id}")["secure_url"]
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
    image_url = params[:image_url]

    if @event.images.include?(image_url)
      # Extract the public ID while keeping the folder structure
      public_id = image_url.split('/').last.split('.').first
      full_public_id = "afrobounce/events/#{@event.id}/#{public_id}"

      Cloudinary::Uploader.destroy(full_public_id) # Delete from Cloudinary

      # Remove the image URL from the event's images array
      @event.update(images: @event.images - [image_url])

      flash[:notice] = "Image deleted successfully"
    else
      flash[:alert] = "Image not found"
    end

    redirect_to event_images_path(@event), status: :see_other
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
