require 'mechanize'
require 'nokogiri'
require 'json'

class Connection
  @signs = nil
  attr_reader :signs
  def initialize
    @base_url = 'http://api.olhovivo.sptrans.com.br/v2.1'
    token = '41a811d106147fd42bb8205ed6ff75a19b3ace1d79564d2ec522cad6fc930f41'
    @agent = Mechanize.new
    @agent.post("#{@base_url}/Login/Autenticar?token=#{token}")
  end

  def lines(terms)
    lines = @agent.get "#{@base_url}/Linha/Buscar?termosBusca=#{terms}"
    parsed_lines = parse_query(lines.body)
    hash_result(parsed_lines, 'cl')
  end

  def stops_per_line(line_code)
    stops = @agent.get "#{@base_url}/Parada/BuscarParadasPorLinha?codigoLinha=#{line_code}"
    parsed_stops = parse_query(stops.body)
    hash_result(parsed_stops, 'cp')
  end

  def parse_query(html_result)
    result_xml = Nokogiri::HTML(html_result, nil, Encoding::UTF_8.to_s)
    result_json = JSON.parse(result_xml.css('body p').inner_html)
    result_json
  end

  def estimate_arrival(stop_code, line_code)
    arrival = @agent.get "#{@base_url}/Previsao?codigoParada=#{stop_code}&codigoLinha=#{line_code} "
    parsed_arrival = parse_query(arrival.body)
    parsed_arrival['hr']
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
