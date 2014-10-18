require 'mocha'
{expect} = require 'chai'

ImageRGBA = require '../lib/image-rgba'

describe 'ImageRGBA', ->
  it 'should be a ImageRGBA class', ->
    expect(ImageRGBA).to.be.a 'function'

    describe 'Methods', ->
      beforeEach  ->
        @imageRGBA = new ImageRGBA()
      it 'should be created from ImageRGBA class', ->
        expect(@imageRGBA).to.be.a 'object'

      describe 'Initialize', ->
        it 'should be an ImageRGBA method', ->
          expect(@imageRGBA.initialize).to.be.a 'function'

        it 'should have width,height,data', ->
          @imageRGBA.initialize 1,2,[0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF]
          expect(@imageRGBA.width).to.equal  1
          expect(@imageRGBA.height).to.equal 2
          expect(@imageRGBA.data).to.deep.equal [0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF]

          expect(@imageRGBA.initialize.bind(@imageRGBA,1,1,1))
              .to.throw Error,/data should be an Array/
          expect(@imageRGBA.initialize.bind(@imageRGBA,1,1,[0x00]))
              .to.throw Error,/data should be an Array\(4x\)/
          expect(@imageRGBA.initialize.bind(@imageRGBA,1,1,[0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF]))
              .to.throw Error,/width,height should be matched with data/

          expect(@imageRGBA.initialize 1,2,[0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF])
              .to.be.a 'object'

      describe 'GetPixcel', ->
