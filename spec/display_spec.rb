require_relative('../lib/display')
require_relative('../lib/api_connection.rb')

describe Display do
  let(:display) { described_class.new }
  let(:connection) { Connection.new }

  describe '#get_signs' do
    let(:hash_lines) { connection.lines('8000') }

    it '#creates a hash of strings from the queried info' do
      expect(display.get_signs(hash_lines)).to(be_a(Hash))

      unless display.get_signs(hash_lines).empty?
        display.get_signs(hash_lines).all? do |_key, value|
          expect(value).to(be_a(String))
        end
      end
    end
  end

  describe '#get_stops' do
    let(:hash_stops) { connection.stops_per_line('8000') }

    it '#creates a hash of strings from the queried info' do
      expect(display.get_stops(hash_stops)).to(be_a(Hash))

      unless display.get_stops(hash_stops).empty?
        display.get_stops(hash_stops).all? do |_key, value|
          expect(value).to(be_a(String))
        end
      end
    end
  end
end
