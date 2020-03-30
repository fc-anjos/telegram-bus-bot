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
    parse_lines(lines.body)
  end

  def parse_lines(lines_body)
    line_xml = Nokogiri::HTML(lines_body, nil, Encoding::UTF_8.to_s)
    line_json = JSON.parse(line_xml.css('body p').inner_html)
    # Returns an array of the found lines
    line_json
  end

  def stops_per_line(line_code)
    stops = @agent.get "#{@base_url}/Parada/BuscarParadasPorLinha?codigoLinha=#{line_code}"
    stops
  end

  def get_signs(lines)
    # TODO: Make it work for circular lines
    @signs = {}
    lines.each do |line|
      line_code = line['cl']
      sign_number = line['lt'].to_s + '-' + line['tl'].to_s
      if line['sl'] == 1
        sign = "#{sign_number} #{line['tp']} => #{line['ts']}"
      elsif line['sl'] == 2
        sign = "#{sign_number} #{line['ts']} => #{line['tp']}"
      end
      @signs[line_code] = sign
    end
  end
end

class Display
  def initialize(signs)
    @signs = signs
  end

  def format_signs
    @signs.each do |_code, sign|
      puts sign
    end
  end
end
