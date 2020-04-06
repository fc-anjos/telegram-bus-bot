<!-- TITLE -->
# bus-statuses 
How long will my bus take? Discover in Telegram sending a message to @bus-statuses-bot
> A telegram bot that will tell you the estimated arrival time for buses in São Paulo

<!-- DESCRIPTION -->
This Telegram bot connects to SPTrans API to estimate the arrival times for a given Bus Line at a Bus Stop.  

<!-- AUTHORS -->
## Check it online!
drop a message to @bus-statuses-bot in Telegram

<!-- SCREENSHOT -->
## Screenshot
[![](screenshot.gif)](#)

## Built With
[Ruby](https://www.ruby-lang.org/)  
[Telegram](https://telegram.org/)  
[telegram-bot-ruby](https://github.com/atipugin/telegram-bot-ruby) (gem)  
[SPTrans API](http://www.sptrans.com.br/desenvolvedores/api-do-olho-vivo-guia-de-referencia/documentacao-api/)  


## Contributing

#### Ruby's version
This project is built with Ruby 2.7.0
If you're running into issues regarding Ruby's version, control your version with [rvm](https://rvm.io/rvm/install) or [rbenv](https://github.com/rbenv/rbenv#installation)

for rvm:
rvm install 2.7.1

for rbenv:
rbenv install 2.7.1
[make sure ruby 2.7.1 is in your PATH](https://stackoverflow.com/questions/10940736/rbenv-not-changing-ruby-version/12150580#12150580)

### API Keys 
You will need API keys to deploy your version of this bot.  

### How to get them:
#### Telegram bot key
A token connects telegram API to a bot. To create a new bot and develop on it, send a message to botfather on telegram. More info about it [here](https://core.telegram.org/bots)  
This token is referenced through the code as TELEGRAM_TOKEN
#### SPTrans Key
A token is required to query buses' informations through SPTrans API. To learn more about how to create a new token, access sptrans website on [this page](http://www.sptrans.com.br/desenvolvedores/api-do-olho-vivo-guia-de-referencia/)  
This token is referenced through the code as SPTRANS_TOKEN 

### API keys on the server:
If you choose to deploy your bot on heroku, you can learn how to configure your environment variables in [this guide](https://devcenter.heroku.com/articles/config-vars)

### API keys to run local tests:
The deployed version of this bot store it's tokens safely.  
To run the tests locally, you will need tokens as environment variables.  
The dotenv gem is already bundled for this purposes and the tests will import the tokens from the file .env.local in the root of this project.  
Create this file with the following content:

```
export TELEGRAM_TOKEN=<your_telegram_token_here>
export SPTRANS_TOKEN=<your_sptrans_token_here>
```

#####Contributions, issues and feature requests are welcome.
You should now be able to handle the needed API Keys. Fork this repo, develop new and features and ask for a pull request. Drop me a message if help is needed.
Feel free to check the [issues page](issues/).  

#####Contributions suggestions:
The project could be improved by adding geo-location features to find the nearest Bus Stop.  
Think you could help us?  
Drop a message here or at felipe.anjos@usp.br  
