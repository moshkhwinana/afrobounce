class SubscribersController < ApplicationController

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subsciber_params)
  end

  private

  def subsciber_params
  end

end
