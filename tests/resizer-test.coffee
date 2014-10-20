require 'mocha'
{expect} = require 'chai'

Resizer   = require '../lib/resizer'
ImageRGBA = require '../lib/image-rgba'

describe 'Resizer', ->
  it 'should be a Resizer class', ->
    expect(Resizer).to.be.a 'function'

    describe 'Methods', ->
      beforeEach  ->
        before = new ImageRGBA()
        data   = []
        for i in [1..(50 * 50)]
          data.push 0x00
          data.push 0x00
          data.push 0x00
          data.push 0xFF

        before.initialize 50,50,data
        @resizer = new Resizer(before)

      it 'should be created from Resizer class', ->
        expect(@resizer).to.be.a 'object'

      describe 'Scale', ->
        it 'should be an Resizer method', ->
          expect(@resizer.scale).to.be.a 'function'
        it 'should be 2x', ->
          expect(@resizer.scale(100,50)).to.equal 2.0
        it 'should be 0.5x', ->
          expect(@resizer.scale(25,10)).to.equal 0.5
        it 'should be 1.0x', ->
          expect(@resizer.scale(10,50)).to.equal 1.0

      describe 'Resize', ->
        it 'should be an Resizer method', ->
          expect(@resizer.resize).to.be.a 'function'
        it 'should be Resized 2x', ->
          after = @resizer.resize 100,5
          expect(after.width).to.equal 100
          expect(after.height).to.equal 100
          afterExpected = new ImageRGBA()
          data   = []
          for i in [1..(100 * 100)]
            data.push 0x00
            data.push 0x00
            data.push 0x00
            data.push 0xFF

          afterExpected.initialize 100,100,data
          expect(after.data).to.deep.equal afterExpected.data
        it 'should be Resized 0.5x', ->
          after = @resizer.resize 10,25
          expect(after.width).to.equal 25
          expect(after.height).to.equal 25
          afterExpected = new ImageRGBA()
          data   = []
          for i in [1..(25 * 25)]
            data.push 0x00
            data.push 0x00
            data.push 0x00
            data.push 0xFF

          afterExpected.initialize 25,25,data
          expect(after.data).to.deep.equal afterExpected.data
