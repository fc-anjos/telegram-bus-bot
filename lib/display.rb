class Display
  def format_signs(signs)
    string = ''
    signs.each_with_index do |(_code, sign), index|
      string += "#{index + 1}:\n#{sign}\n"
    end
    string
  end
end
