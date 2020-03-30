require 'mechanize'

class Connection
  @agent = nil
  def initialize
    token = '41a811d106147fd42bb8205ed6ff75a19b3ace1d79564d2ec522cad6fc930f41'
    @agent = Mechanize.new
    @agent.post("http://api.olhovivo.sptrans.com.br/v2.1/Login/Autenticar?token=#{token}")
  end

  def lines(terms)
    lines = @agent.get "http://api.olhovivo.sptrans.com.br/v2.1/Linha/Buscar?termosBusca=#{terms}"
    lines.body
  end
end

p Connection.new.lines('8000')
