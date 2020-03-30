require 'api_connection'

class Display
  def format_signs(signs)
    string = ''
    signs.each_with_index do |(_code, sign), index|
      string += "#{index + 1}:\n#{sign}\n"
    end
    string
  end
end

connection = Connection.new
lines = connection.lines('8000')
signs = connection.get_signs(lines)
Display.new.format_signs(signs)
