require_relative('../lib/message_logic.rb')

describe MessageLogic do
  let(:message_logic) { described_class.new }

  describe '#prepare_selection' do
    let(:input_hash) { { one: 'a', two: 'b', three: 'c' } }
    let(:expected_hash) { { 0 => :one, 1 => :two, 2 => :three } }

    it 'creates a hash with the indexes as keys' do
      expect(message_logic.prepare_selection(input_hash)).to(eq(expected_hash))
    end
  end
end
