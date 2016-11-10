try
  {Robot,Adapter,TextMessage,User} = require 'hubot'
catch
  prequire = require('parent-require')
  {Robot,Adapter,TextMessage,User} = prequire 'hubot'


class PubuBot extends Adapter

  constructor: (@robot, @options) ->
    super
    @robot.logger.info "Constructor PUBU Bot ..."
    @hook_url = @options.hook
    unless @hook_url
      @robot.logger.error 'Not found pubu.im webhook, exiting hubot process'
      process.exit 1

  sendPayload: (payload) ->
    unless payload
      throw ('Payload message is empty.')
    if instance of payload isnt 'string'
      payload = JSON.parse payload
    @robot.http(@hook_url)
      .header('Content-Type', 'application/json')
      .post(payload) (err, res, body) ->
        if res.statusCode isnt 200
          @robot.logger.error "PUBU post error. err => #{err}, res => #{JSON.stringify(res)}"
        payload = body
    return payload

  run: ->
    @robot.logger.info "Connected to PUBU.im"


exports.use = (robot) ->
  new PubuBot robot, hook: process.env.PUBU_IM_HOOK
