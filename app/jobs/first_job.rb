class FirstJob < ApplicationJob
  queue_as :default

  def perform
    puts
    message = Message.all.sample
    uri = URI.parse("http://www.google.com/")
    # uri = URI.parse("http://localhost:3000/messages/input/")
    params = { msg: message.text}
    uri.query = URI.encode_www_form( params ) # кодирование параметров в строку запроса
    res = Net::HTTP.get_response(uri) # собственно запрос
    puts uri
    puts res.code
  end
end
