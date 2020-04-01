require 'rubygems'
require 'telegram/bot'
require_relative '../lib/display'
require_relative '../lib/api_connection'

token = '1007984866:AAHy5tUA-a_Vo5U8KTxKpLbB1SkZ-FZJX_E'

def show_lines(message, bot, connection, display)
  lines = connection.lines(message)
  signs = display.get_signs(lines)
  signs = display.format_message(signs)
  bot.api.send_message(chat_id: message.chat.id, text: 'Please select your line')
  bot.api.send_message(chat_id: message.chat.id, text: signs)
  chosen = select_lines(bot, display, lines)
  chosen
end

def select_lines(bot, display, lines)
  bot.listen do |message|
    options = display.prepare_selection(lines)
    choice = nil
    until choice
      begin
        choice = message.text.to_i
      rescue StandardError
        bot.api.send_message(chat_id: message.chat.id, text: 'Invalid number selected!')
      end
    end
    return options[choice - 1] if choice <= options.length && choice.positive?

    bot.api.send_message(chat_id: message.chat.id, text: 'Invalid number selected!')
    return false
  end
end

def show_stops(message, line_code, bot, connection, display)
  stops_hash = connection.stops_per_line(line_code)
  stops = display.get_stops(stops_hash)
  stops = display.format_message(stops)

  bot.api.send_message(chat_id: message.chat.id, text: stops)

  bot.listen do |message_stop|
    chosen = nil
    return select_stop(message_stop, bot, display, stops_hash) until chosen
  end
end

def select_stop(message, bot, display, stops_hash)
  options = display.prepare_selection(stops_hash)
  choice = message.text.to_i
  return options[choice - 1] if choice <= options.length && choice.positive?

  bot.api.send_message(chat_id: message.chat.id, text: 'Invalid stop selected!')
  false
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
    #       'você quebrou o robozinho')

    else
      line_code = nil
      line_code = show_lines(message, bot, connection, display) until line_code
      bot.api.send_message(chat_id: message.chat.id, text: line_code)
      bot.api.send_message(chat_id: message.chat.id, text: 'Please select your stop')
      stop = show_stops(message, line_code, bot, connection, display)
      bot.api.send_message(chat_id: message.chat.id, text: "Your stop is: #{stop}")
    end
  end
end
