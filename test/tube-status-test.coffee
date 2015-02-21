chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'tube-status', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()

    require('../src/tube-status')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/tube status/)
