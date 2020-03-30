require 'rubygems'
require 'telegram/bot'
require_relative '../lib/api_connection.rb'
token = '1007984866:AAHy5tUA-a_Vo5U8KTxKpLbB1SkZ-FZJX_E'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Fala,  #{message.from.first_name}!" \
                           'Vou fazer um robô pra te mandar um alôzinho então, demorou??')

    else
      connection = Connection.new
      lines = connection.lines(message)
      connection.get_signs(lines)
      connection.signs.each do |_code, sign|
        bot.api.send_message(chat_id: message.chat.id, text: sign)
      end
    end
  end
end
