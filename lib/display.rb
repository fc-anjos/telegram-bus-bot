class Display
  def initialize; end

  def get_signs(hash_lines)
    signs = {}
    hash_lines.each do |code, line|
      line_code = code
      sign_number = line['lt'].to_s + '-' + line['tl'].to_s
      if line['lc']
        sign = "#{sign_number}\n#{line['tp']} (#{line['ts']})"
      elsif line['sl'] == 1
        sign = "#{sign_number}\n#{line['tp']} => #{line['ts']}"
      elsif line['sl'] == 2
        sign = "#{sign_number}\n#{line['ts']} => #{line['tp']}"
      end
      signs[line_code] = sign
    end
    signs
  end

  def format_signs(hash_lines)
    string = ''
    hash_lines.each_with_index do |(_code, sign), index|
      string += "\n" if index >= 0
      string += "#{index + 1}:\n#{sign}\n"
    end
    string
  end

  def prepare_selection(hash_lines)
    selections = {}
    hash_lines.each_with_index do |(code, _sign), index|
      selections[index] = code
    end
    selections
  end
end
