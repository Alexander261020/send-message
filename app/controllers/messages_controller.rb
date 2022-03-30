class MessagesController < ApplicationController
  require 'open-uri'
  require 'uri'
  require 'net/http'

  def index
    @messages = Message.all
  end

  def send_message
    if params[:uri].match(/^(http){1}s?(:\/\/){1}[\w.\/]*/)
      uri = params[:uri]
    else
      uri = ENV["URL_FOR_SEND"]
    end
    t1 = Time.now + params[:score].to_i.second
    t2 = t1 + params[:score_show].to_i.second
    # добавляем 3тий показ на завтра
    schedule = [t1, t2, Date.tomorrow.noon]

    csore_messages = params[:messages].to_i
    interval = params[:interval].to_i

    schedule.each do |item|
      ScheduleJob.set(wait_until: item).perform_later(csore_messages, interval, uri)
    end
    redirect_to root_path
  end

  def create
    message = Message.create(text: params[:text])
    redirect_to root_path
  end
end
