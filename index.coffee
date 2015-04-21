# file: index.coffee

EventEmitter = require('events').EventEmitter

class Plugin extends EventEmitter
  constructor: (@app, @opts)->
    @uuid = @opts?.uuid or require('uuid')
    @name = 'uuid'
    @app.hook (req, res, next)=>
      req.body.id = @uuid.v1() unless req.body?.id?
      next null

module.exports = (app, opts)->
  return new Plugin app, opts
