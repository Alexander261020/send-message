class MessagesController < ApplicationController
  require 'open-uri'
  require 'uri'
  require 'net/http'

  def index
    @messages = Message.all
  end

  def send_message
    SendMessages.(params)
    redirect_to root_path
  end

  def create
    message = Message.create(text: params[:text])
    redirect_to root_path
  end
end
