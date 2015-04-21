# file: test/test_plugin_uuid.coffee

should = require 'should'
sinon = require 'sinon'
EventEmitter = require('events').EventEmitter
uuid = require 'uuid'

describe 'uuid Plugin', ->

  beforeEach ->
    @app = new EventEmitter()
    @hooks = []
    @req =
      method: 'POST'
      body:
        name: 'Test'
    @res = {}
    @hook = (fn)=>
      @hooks.push fn
    @app.hook = sinon.spy @hook
    @opts = {}
    @plugin = require("#{__dirname}/../index")(@app, @opts)

  it 'should expose its right name', ->
    @plugin.name.should.equal 'uuid'

  it 'should add one hook to the app', ->
    @app.hook.calledOnce.should.be.ok
    @hooks.length.should.equal 1

  it 'should add a unique property `id` to the parsed body if HTTP method == POST', (done)->
    callback = (err)=>
      callback.calledOnce.should.be.ok
      @req.body.should.have.property 'id'
      isUUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
      isUUID.test(@req.body.id).should.be.ok
      done null
    callback = sinon.spy(callback)
    @hooks[0](@req, @res, callback)
