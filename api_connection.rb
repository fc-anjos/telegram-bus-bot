require 'mechanize'

class Connection
  @agent = nil
  def initialize
    @agent = Mechanize.new
    @agent.post('http://api.olhovivo.sptrans.com.br/v2.1/Login/Autenticar?token=41a811d106147fd42bb8205ed6ff75a19b3ace1d79564d2ec522cad6fc930f41')
  end

  def search(term)
    result = @agent.get "http://api.olhovivo.sptrans.com.br/v2.1/Linha/Buscar?termosBusca=#{term}"
    result.body
  end
end

connection = Connection.new
result = connection.search('8000')
puts result
# agent = Mechanize.new
# agent.post('http://api.olhovivo.sptrans.com.br/v2.1/Login/Autenticar?token=41a811d106147fd42bb8205ed6ff75a19b3ace1d79564d2ec522cad6fc930f41')
# page = agent.get 'http://api.olhovivo.sptrans.com.br/v2.1/Linha/Buscar?termosBusca=8000'
# puts page.body
