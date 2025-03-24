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
    uploaded_files = (params[:event][:images] || []).compact.reject(&:blank?) # Remove blank values

    if uploaded_files.any?
      uploaded_urls = []

      uploaded_files.each do |file|
        if file.respond_to?(:tempfile) && File.exist?(file.tempfile.path) # Ensure file exists
          uploaded_urls << Cloudinary::Uploader.upload(file, folder: "afrobounce/events/#{@event.id}")["secure_url"]
        else
          Rails.logger.error "File not found: #{file.inspect}"
        end
      end

      if uploaded_urls.any?
        @event.images = (@event.images || []) + uploaded_urls
        if @event.save
          flash[:notice] = "Images uploaded successfully!"
          redirect_to event_images_path(@event)
        else
          flash[:alert] = "Failed to save images."
          render :new
        end
      else
        flash[:alert] = "No valid images uploaded."
        render :new
      end
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
  end

  def event_params
    params.require(:event).permit(:name, :date, :cover_image, images: [])
  end
end
