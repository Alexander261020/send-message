class ScheduleJob < ApplicationJob
  queue_as :default

  def perform(score_messages, interval)
    interval = rand(1) if interval == nil
    score_messages = rand(1..3) if score_messages == nil

    time_message = 0
    score_messages.times.with_index do |index|
      puts
      puts "index = #{index}"
      time_show = Time.new + time_message.second

      FirstJob.set(wait_until: time_show).perform_later
      time_message += interval
    end
  end
end
