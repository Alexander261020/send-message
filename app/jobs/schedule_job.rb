class ScheduleJob < ApplicationJob
  queue_as :default

  def perform(csope_messages, interval, uri, messages)
    logger = Logger.new('./log/dev/logfile.log')

    csope_messages = rand(1..5) if csope_messages == nil

    time_message = 0
    csope_messages.times do
      time_show = Time.new + time_message.second
      message = messages.sample

      if message.present?
        logger.debug " exist message: '#{message}'"

        SendJob.set(wait_until: time_show).perform_later(uri, message)
        interval == nil ? time_message += rand(10) : time_message += interval
        messages.delete(message)
      else
        logger.error " existing message: '#{message}'"
      end
    end
  end
end
