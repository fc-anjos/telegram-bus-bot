require_relative '../lib/api_connection'

describe Connection do
  describe '#initialize' do
    let(:connection) { described_class.new }

    it 'Creates a Mechanize agent as a class instance variable' do
      expect(connection.instance_variable_get(:@agent)).to be_a(Mechanize)
    end

    it 'Succesfully connects to the SPTrans api' do
      expect(connection.status).to be(true)
    end
  end
end
