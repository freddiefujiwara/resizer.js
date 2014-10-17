require 'mocha'
{assert} = require 'chai'

Resizer = require '../lib/resizer'

describe 'Resizer', ->
  it 'should be a Resizer class', ->
    assert.typeOf Resizer , 'function'
