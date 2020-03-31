require 'rubygems'
require 'telegram/bot'
require_relative '../lib/display'
require_relative '../lib/api_connection'

token = '1007984866:AAHy5tUA-a_Vo5U8KTxKpLbB1SkZ-FZJX_E'

def select_lines(message, bot, connection, display)
  lines = connection.lines(message)
  signs = display.get_signs(lines)
  signs = display.format_signs(signs)
  bot.api.send_message(chat_id: message.chat.id, text: signs)
end

Telegram::Bot::Client.run(token) do |bot|
  connection = Connection.new
  display = Display.new

  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Fala,  #{message.from.first_name}!" \
                           'Vou fazer um robô pra te mandar um alôzinho então, demorou??')

    #     else
    #       bot.api.send_message(chat_id: message.chat.id, text: "Foi mal,  #{message.from.first_name}!" \
    #    'você quebrou o robozinho')

    else
      select_lines(message, bot, connection, display)

      bot.listen do |message2|
        options = display.prepare_selection(lines)
        chosen = options[(message2.text.to_i - 1)]
        bot.api.send_message(chat_id: message.chat.id, text: chosen)
      end

    end
  end
end
