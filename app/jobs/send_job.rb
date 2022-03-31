class SendJob < ApplicationJob
  queue_as :default

  def perform(uri, message)
    logger = Logger.new('./log/dev/logfile.log')

    url_send = URI.parse(uri)
    params = { msg: message }
    url_send.query = URI.encode_www_form( params ) # кодирование параметров в строку запроса
    res = Net::HTTP.get_response(url_send) # запрос

    # проверяем статус ответа
    if res.code.match(/20*/)
      logger.info('SendJob') { "URL: #{url_send}; Status answer #{res.code}" }
    else
      logger.error('SendJob') { "URL: #{url_send}; Status answer #{res.code}" }
    end
  end
end
