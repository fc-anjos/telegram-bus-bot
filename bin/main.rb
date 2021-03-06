require('rubygems')
require('telegram/bot')
require_relative('../lib/display')
require_relative('../lib/api_connection')
require_relative('../lib/message_logic')

class BusBot
  def initialize
    @token = ENV['TELEGRAM_TOKEN'].to_s
    @connection = Connection.new
    @display = Display.new
    @message_logic = MessageLogic.new
    start_bot
  end

  private

  def start_bot
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          start_message(message, bot)
        else
          line_code = nil
          line_code = show_lines(message, bot) until line_code
          bot.api.send_message(chat_id: message.chat.id, text: 'Please select your stop by typing an option number')
          bot.api.send_message(chat_id: message.chat.id, text: 'Options:')
          stop_code = show_stops(message, line_code, bot)
          message_arrival_time(message, bot, stop_code, line_code)
        end
      end
    end
  end

  def start_message(message, bot)
    bot.api.send_message(
      chat_id: message.chat.id,
      text: "Hello,  #{message.from.first_name}!" \
                  'This is a bot that will help you getting the estimated arrival times for buses in São Paulo '
    )
    bot.api.send_message(
      chat_id: message.chat.id,
      text: '' \
                'To start you first search, just type a bus number or part of it\'s name '
    )
    bot.api.send_message(chat_id: message.chat.id, text: '(e.g. 8000)')
  end

  def message_arrival_time(message, bot, stop_code, line_code)
    hash_arrivals = @connection.estimate_arrival(stop_code, line_code)
    arrivals_list = @display.get_arrivals(hash_arrivals)
    if arrivals_list.empty?
      bot.api.send_message(chat_id: message.chat.id, text: 'There are no expected arrivals for this line at this stop!')
    else
      format_arrivals = @display.format_arrivals(arrivals_list)
      bot.api.send_message(chat_id: message.chat.id, text: "Your bus should arrive at #{format_arrivals}")
    end
  end

  def show_lines(message, bot)
    begin
      lines = @connection.lines(message)
    rescue StandardError
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "We couldn't find a line that matches this search," \
                                   'please try again!'
      )
      return start_bot
    end
    signs = @display.get_signs(lines)
    signs = @display.format_message(signs)
    bot.api.send_message(chat_id: message.chat.id, text: 'Please select your line by typing an option number')
    bot.api.send_message(chat_id: message.chat.id, text: 'Options:')
    bot.api.send_message(chat_id: message.chat.id, text: signs)
    chosen = select_lines(bot, lines)
    chosen
  end

  def show_stops(message, line_code, bot)
    stops_hash = @connection.stops_per_line(line_code)
    stops = @display.get_stops(stops_hash)
    stops = @display.format_message(stops)
    bot.api.send_message(chat_id: message.chat.id, text: stops)

    bot.listen do |message_stop|
      chosen = nil
      return select_stop(message_stop, bot, stops_hash) until chosen
    end
  end

  def select_lines(bot, lines)
    bot.listen do |message|
      options = @message_logic.prepare_selection(lines)
      choice = rescued_choice(message)
      return options[choice - 1] if choice <= options.length && choice.positive?

      bot.api.send_message(chat_id: message.chat.id, text: 'Invalid number selected!')
      return false
    end
  end

  def select_stop(message, bot, stops_hash)
    options = @message_logic.prepare_selection(stops_hash)
    choice = rescued_choice(message)
    return options[choice - 1] if choice <= options.length && choice.positive?

    bot.api.send_message(chat_id: message.chat.id, text: 'Invalid stop selected!')
    false
  end

  def rescued_choice(message)
    choice = nil
    until choice
      begin
        choice = Integer(message.text, 10)
      rescue StandardError
        bot.api.send_message(chat_id: message.chat.id, text: 'Invalid number selected!')
      end
    end
    choice
  end
end

BusBot.new
