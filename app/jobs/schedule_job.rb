class ScheduleJob < ApplicationJob
  queue_as :default

  def perform(csope_messages, interval)
    csope_messages = rand(1..3) if csope_messages == nil

    time_message = 0
    csope_messages.times do
      time_show = Time.new + time_message.second

      FirstJob.set(wait_until: time_show).perform_later

      interval == nil ? time_message += rand(10) : time_message += interval
    end
  end
end
