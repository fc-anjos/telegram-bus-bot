require 'rubygems'
require 'telegram/bot'
require 'api_connection'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Fala,  #{message.from.first_name}! Vou fazer um robô pra te mandar um alôzinho então, demorou??")
    when '/8000'
      search_result = Connection.new.search('8000')
      bot.api.send_message(chat_id: message.chat.id, text: search_result.to_s)
    when '/end'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}!")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "I don't understand you :(")
    end
  end
end
