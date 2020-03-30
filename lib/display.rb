require 'api_connection'

class Display
  # def initialize
  # @signs = signs
  # end

  def format_signs(signs)
    signs.each do |_code, sign|
      puts sign
    end
  end
end

connection = Connection.new
lines = connection.lines('8000')
signs = connection.get_signs(lines)
Display.new.format_signs(signs)
