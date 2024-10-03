class ContactmessagesController < ApplicationController

  def new
    @message = ContactMessage.new
  end

  def create
    @message = ContactMessage.new(strong_params)
    if @message.save
      
    end
  end
end
