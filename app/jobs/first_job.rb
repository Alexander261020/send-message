class FirstJob < ApplicationJob
  queue_as :default

  def perform
    puts
    t1 = Time.new
    messages = Message.all
    message = messages.sample
    puts "FIRST JOB = #{message.text}  -   #{t1}"
  end
end
