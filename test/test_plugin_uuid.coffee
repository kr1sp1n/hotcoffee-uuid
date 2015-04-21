# file: test/test_plugin_uuid.coffee

should = require 'should'
sinon = require 'sinon'
EventEmitter = require('events').EventEmitter

describe 'uuid Plugin', ->

  beforeEach ->
    @app = new EventEmitter()
    @app.hook=  sinon.stub()
    @opts = {}
    @plugin = require("#{__dirname}/../index")(@app, @opts)

  it 'should expose its right name', ->
    @plugin.name.should.equal 'uuid'

  it 'should add a unique property `id` to the parsed body if HTTP method == POST', (done)->

    done null
