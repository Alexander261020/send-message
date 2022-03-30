class SendMessages
  def self.call(params)
    if params[:uri].match(/^(http){1}s?(:\/\/){1}[\w.\/]*/)
      uri = params[:uri]
    else
      uri = ENV["URL_FOR_SEND"]
    end

    score = params[:score].to_i
    time_show = Time.now
    next_show = params[:score_show].to_i.second

    csore_messages = params[:messages].to_i
    interval = params[:interval].to_i

    score.times do
      ScheduleJob.set(wait_until: time_show).perform_later(csore_messages, interval, uri)
      time_show += next_show
    end
  end
end
