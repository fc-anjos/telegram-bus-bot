require_relative './api_connection.rb'

class Display
  def format_signs(signs)
    string = ''
    signs.each_with_index do |(_code, sign), index|
      string += "\n" if index >= 0
      string += "#{index + 1}:\n#{sign}\n"
    end
    string
  end
end

connection = Connection.new
lines = connection.lines('8000')
signs = connection.get_signs(lines)
answer = Display.new.format_signs(signs)
puts answer
