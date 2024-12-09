class ImagesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]

  def index
    @images = Image.all
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
