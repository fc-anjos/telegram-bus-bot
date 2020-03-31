require 'rubygems'
require 'telegram/bot'
require_relative '../lib/api_connection'
require_relative '../lib/display'
token = '1007984866:AAHy5tUA-a_Vo5U8KTxKpLbB1SkZ-FZJX_E'

Telegram::Bot::Client.run(token) do |bot|
  connection = Connection.new
  display = Display.new

  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Fala,  #{message.from.first_name}!" \
                           'Vou fazer um robô pra te mandar um alôzinho então, demorou??')

    else
      lines = connection.lines(message)
      signs = display.get_signs(lines)
      question = display.format_signs(signs)
      answers = display.prepare_selection(lines)
      bot.api.send_message(chat_id: message.chat.id, text: question)
      # bot.listen do |answer|
      # case message.text
      # when '/help'
      # puts 'ok'
      # else
      # chosen = answers[answer.to_i]
      # bot.api.send_message(chat_id: message.chat.id, text: chosen)
      # end
      # end
    end
  end
end
