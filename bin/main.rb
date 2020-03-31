require 'rubygems'
require 'telegram/bot'
# require_relative '../lib/api_connection'
# require_relative '../lib/display'
token = '1007984866:AAHy5tUA-a_Vo5U8KTxKpLbB1SkZ-FZJX_E'

Telegram::Bot::Client.run(token) do |bot|
  # connection = Connection.new
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Fala,  #{message.from.first_name}!" \
                           'Vou fazer um robô pra te mandar um alôzinho então, demorou??')

      # else
      # lines = connection.lines(message)
      # signs = connection.get_signs(lines)
      # answer = Display.new.format_signs(signs)
      # bot.api.send_message(chat_id: message.chat.id, text: answer)
    end
  end
end
