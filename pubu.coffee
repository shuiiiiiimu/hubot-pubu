try
  {Robot,Adapter,TextMessage,User} = require 'hubot'
catch
  prequire = require('parent-require')
  {Robot,Adapter,TextMessage,User} = prequire 'hubot'

class Pubu extends Adapter

  constructor: ->
    super
    @robot.logger.info "Constructor PUBU ..."

  send: (envelope, strings...) ->
    @robot.logger.info "Send"

  reply: (envelope, strings...) ->
    @robot.logger.info "Reply"

  run: ->
    @robot.logger.info "Run"
    @emit "connected"
    user = new User 1001, name: 'Pubu User'
    message = new TextMessage user, 'Some Pubu Message', 'MSG-001'
    @robot.receive message


exports.use = (robot) ->
  new Pubu robot
