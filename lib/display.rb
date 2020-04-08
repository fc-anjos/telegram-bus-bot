class Display
  def initialize; end

  def get_signs(hash_lines)
    signs = {}
    hash_lines.each do |code, line|
      line_code = code
      sign_number = line[:lt].to_s + '-' + line[:tl].to_s
      if line[:lc]
        sign = "#{sign_number}\n#{line[:tp]} (#{line[:ts]})"
      elsif line[:sl] == 1
        sign = "#{sign_number}\n#{line[:tp]} => #{line[:ts]}"
      elsif line[:sl] == 2
        sign = "#{sign_number}\n#{line[:ts]} => #{line[:tp]}"
      end
      signs[line_code] = sign
    end
    signs
  end

  def get_arrivals(parsed_arrivals)
    arrivals = []
    begin
    parsed_arrivals['p']['l'].each do |line|
      line['vs'].each do |vehicle|
        arrivals.push(vehicle['t'])
      end
    end
    rescue StandardError
      arrivals
  end
    arrivals
  end

  def format_arrivals(arrivals_list)
    string = ''
    arrivals_list.each_with_index do |time, index|
      string +=
        if index.zero?
          time.to_s
        elsif index == 1
          " and then at #{time}"
        else
          ", #{time}"
        end
    end
    string
  end

  def get_stops(hash_stops)
    stops = {}
    hash_stops.each do |code, stop|
      stop_code = code
      stop_name = stop[:np]
      stop_address = stop[:ed]
      stops[stop_code] = "Stop #{stop_name} at #{stop_address}"
    end
    stops
  end

  def format_message(hash)
    string = ''
    hash.each_with_index do |(_key, value), index|
      string += "\n" if index >= 0
      string += "#{index + 1}\n#{value}\n"
    end
    string
  end
end
