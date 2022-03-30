class MessagesController < ApplicationController
  SCHEDULE = [Date.tomorrow.noon]

  def index
    @messages = Message.all
    @ex = Time.new
    @t1 = @ex + 2.second
    @t2 = @t1 + 2.second
    @time_now = Time.new
    # расписание показов сообщений
    interval_show = 16
    seconds = 10

    # количество и интервал
    score_messages = 5
    interval = 2
    #############################################
    2.times do
    # SCHEDULE.each do |item|
                            #############
      ScheduleJob.set(wait: seconds.second).perform_later(score_messages, interval)
      seconds += interval_show
    end
  end

  def create
    message = Message.create(text: params[:text])
    redirect_to root_path
  end
end
