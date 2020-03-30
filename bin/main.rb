require 'rubygems'
require 'telegram/bot'
require_relative '../lib/api_connection.rb'
require_relative '../lib/display.rb'

Telegram::Bot::Client.run(token) do |bot|
  connection = Connection.new
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Fala,  #{message.from.first_name}!" \
                           'Vou fazer um robô pra te mandar um alôzinho então, demorou??')

    else
      lines = connection.lines(message)
      signs = connection.get_signs(lines)
      message = Display.new.format_signs(signs)
      bot.api.send_message(chat_id: message.chat.id, text: message)
    end
  end
end
