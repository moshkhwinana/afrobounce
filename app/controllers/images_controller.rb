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
    logger.debug "Params received: #{params.inspect}" # Debugging

    if params[:event] && params[:event][:images].present?
      uploaded_files = Array.wrap(params[:event][:images]).reject(&:blank?) # Remove empty strings
      logger.debug "Files received after filtering: #{uploaded_files.inspect}" # Debugging

      if uploaded_files.any?
        uploaded_files.each do |file|
          @event.images.attach(file)
          logger.debug "Attached file: #{file.respond_to?(:original_filename) ? file.original_filename : 'Unknown file'}" # Avoid error
        end
        redirect_to event_images_path(@event), notice: 'Images uploaded successfully'
      else
        flash.now[:alert] = 'No valid images selected'
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = 'Please select at least one image to upload'
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
    params.require(:event).permit(images: [])
  end
end
