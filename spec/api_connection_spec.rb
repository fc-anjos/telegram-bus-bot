require_relative('../lib/api_connection')

describe Connection do
  let(:connection) { described_class.new }

  describe '#initialize' do
    it 'Creates a Mechanize agent as a class instance variable' do
      expect(connection.instance_variable_get(:@agent)).to(be_a(Mechanize))
    end

    it 'Succesfully connects to the SPTrans api' do
      expect(connection.status).to(be(true))
    end
  end

  describe '#hash_results' do
    let(:string_json) { JSON.parse('[{"1":"A","value_1":1,"value_2":"2"}]') }

    it 'formats the hash' do
      connection.lines('8000')
      # actual_hash = connection.send(:hash_result, string_json, '1')
      # expected_hash = {"A"=>{"value_1"=>1, "value_2"=>"2"}}
      # expect(actual_hash).to(eql(expected_hash))
    end
  end
end
