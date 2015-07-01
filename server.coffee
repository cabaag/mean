path = require 'path'
express = require 'express'
mongoose = require 'mongoose'

# cookieParser = require('cookie-parser')
# bodyParser = require('body-parser')
# session = require('express-session')
# configDB = require './config/database.coffee'
# mongoose.connect(configDB.url)
module.exports = ->
  app = express()
  #
  # app.use(cookieParser())
  # app.use(bodyParser.urlencoded({
  #   extended: true
  # }))
  # app.use(bodyParser.json())
  #
  app.set('views', "#{__dirname}/www/views")
  app.set('view engine', 'jade')
  # app.get '/', (req, res)->
  #   res.sendFile("#{__dirname}/www/index.html")
  # app.use(session({
  #     secret: 'charliecharlie'
  # }))
  # app.use(passport.initialize())
  # app.use(passport.session())
  app.use(express.static("#{__dirname}/www/public/"))
  # require('./config/passport')(passport)
  require('./app/routes.coffee')(app)
  port = process.env.PORT || 8080
  app.listen(port)

  console.log('Server running on port ' + port)
