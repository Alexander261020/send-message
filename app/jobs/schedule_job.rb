class ScheduleJob < ApplicationJob
  queue_as :default

  def perform(csope_messages, interval, uri, messages)
    csope_messages = rand(1..5) if csope_messages == nil

    time_message = 0
    csope_messages.times do
      time_show = Time.new + time_message.second

      SendJob.set(wait_until: time_show).perform_later(uri, messages.sample)

      interval == nil ? time_message += rand(10) : time_message += interval
    end
  end
end
