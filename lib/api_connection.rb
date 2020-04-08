require('mechanize')
require('nokogiri')
require('json')

class Connection
  attr_reader :status
  @status = false

  def initialize
    @base_url = 'http://api.olhovivo.sptrans.com.br/v2.1'
    token = ENV['SPTRANS_TOKEN'].to_s
    @agent = Mechanize.new
    status = @agent.post("#{@base_url}/Login/Autenticar?token=#{token}").body
    @status = true if status.downcase == 'true'
  end

  def lines(terms)
    lines = @agent.get("#{@base_url}/Linha/Buscar?termosBusca=#{terms}")
    parsed_lines = parse_query(lines.body)
    hash_result(parsed_lines, 'cl')
  end

  def stops_per_line(line_code)
    stops = @agent.get("#{@base_url}/Parada/BuscarParadasPorLinha?codigoLinha=#{line_code}")
    parsed_stops = parse_query(stops.body)
    hash_result(parsed_stops, 'cp')
  end

  def estimate_arrival(stop_code, line_code)
    arrival = @agent.get("#{@base_url}/Previsao?codigoParada=#{stop_code}&codigoLinha=#{line_code} ")
    parse_query(arrival.body)
  end

  def arrivals_at_stop(stop_code)
    arrival = @agent.get("#{@base_url}//Previsao/Parada?codigoParada=#{stop_code}")
    puts(arrival.body)
  end

  private

  def parse_query(html_result)
    result_xml = Nokogiri::HTML(html_result, nil, Encoding::UTF_8.to_s)
    result_json = JSON.parse(result_xml.css('body p').inner_html)
    result_json
  end

  def hash_result(results_json, code_key)
    hash = {}
    results_json.each do |result|
      code = result.delete(code_key)
      hash[code] = result
    end
    hash
  end
end
