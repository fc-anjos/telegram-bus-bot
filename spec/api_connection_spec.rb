require_relative '../lib/api_connection'

describe Connection do
  let(:connection) { Connection.new }
  specify { expect(connection).to be_a GameLogic }
end
