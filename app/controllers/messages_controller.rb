class MessagesController < ApplicationController
  require 'open-uri'
  require 'uri'
  require 'net/http'

  def index
    @messages = Message.all
    # расписание показов сообщений
      # начиная с 5 секунды после запуска
      t1 = Time.now + 5.second
      t2 = Time.now + 15.second
      schedule = [t1, t2, Date.tomorrow.noon]

    # отправляем 3 сообщения с интервалом в 2 секунды
    csope_messages = 3 # если nil то от 1 до 5
    interval = 2 # если nil то рандомная величина до 10 сек

=begin     schedule.each do |item|
      ScheduleJob.set(wait_until: item).perform_later(csope_messages, interval)
    end
=end
  end

  def send_message

    params.ssss
    schedule.each do |item|
      ScheduleJob.set(wait_until: item).perform_later(csope_messages, interval)
    end
  end

  def create
    message = Message.create(text: params[:text])
    redirect_to root_path
  end
end
