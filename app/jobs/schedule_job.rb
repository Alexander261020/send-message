class ScheduleJob < ApplicationJob
  queue_as :default

  def perform(csope_messages, interval, uri)
    logger = Logger.new('./log/dev/logfile.log')
    csope_messages = rand(1..5) if csope_messages == nil

    time_message = 0
    csope_messages.times do
      time_show = Time.new + time_message.second

      SendJob.set(wait_until: time_show).perform_later(uri)

      interval == nil ? time_message += rand(10) : time_message += interval
    end
  end
end
