class MessageLogic
  def initialize; end

  def prepare_selection(hash)
    selections = {}
    hash.each_with_index do |(code, _sign), index|
      selections[index] = code
    end
    selections
  end
end
