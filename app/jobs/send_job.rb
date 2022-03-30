class SendJob < ApplicationJob
  queue_as :default

  def perform
    logger = Logger.new('./log/dev/logfile.log')
    logger.datetime_format = "%Y-%m-%d %H:%M:%S"

    message = Message.all.sample.text

    if message.nil?
      logger.error " existing message: '#{message}'"
    else
      logger.debug "Message existed: '#{message}'"
    end

    uri = URI.parse(ENV["URL_FOR_SEND"])
    params = { msg: message }
    uri.query = URI.encode_www_form( params ) # кодирование параметров в строку запроса
    res = Net::HTTP.get_response(uri) # собственно запрос

    # проверяем статус ответа
    if res.code.match(/20*/)
      logger.info('FirstJob') { "URL: #{uri}; Status answer #{res.code}" }
    else
      logger.error('FirstJob') { "URL: #{uri}; Status answer #{res.code}" }
    end
    logger.close
  end
end
