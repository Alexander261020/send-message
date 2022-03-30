class MessagesController < ApplicationController
  require 'open-uri'
  require 'uri'
  require 'net/http'

  def input
    @message = params[:msg]
  end

  def index
    @messages = Message.all
    # расписание показов сообщений
      # начиная с 10 секунды после запуска
      seconds = 5
      # с интервалом в 16 секунд
      interval_show = 16
      schedule = [seconds, seconds + interval_show]

    # отправляем 5 сообщений с интервалом в 2 секунды
    csope_messages = 3
    interval = 1 # если nil то рандомная величина до 10 сек

    schedule.each do |item|
      ScheduleJob.set(wait: item.second).perform_later(csope_messages, interval)
      seconds += interval_show
    end
  end

  def create
    message = Message.create(text: params[:text])
    redirect_to root_path
  end
end
