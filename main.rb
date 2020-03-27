token = '1007984866:AAHy5tUA-a_Vo5U8KTxKpLbB1SkZ-FZJX_E'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
  end
end
