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
    parsed_lines = parse_lines(lines.body)
    hash_lines(parsed_lines)
  end

  def parse_lines(lines_body)
    line_xml = Nokogiri::HTML(lines_body, nil, Encoding::UTF_8.to_s)
    line_json = JSON.parse(line_xml.css('body p').inner_html)
    line_json
  end

  def hash_lines(line_json)
    lines = {}
    line_json.each do |line|
      code = line.delete('cl')
      lines[code] = line
    end
    lines
  end

  def stops_per_line(line_code)
    stops = @agent.get "#{@base_url}/Parada/BuscarParadasPorLinha?codigoLinha=#{line_code}"
    stops
  end

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
end
