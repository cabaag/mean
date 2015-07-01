module.exports = (app)->
  #route for home page
  # app.get '/', (req, res)->
  #   res.sendFile("#{__dirname}/www/index.html")
  app.get '/', (req, res)->
    res.render('index')
