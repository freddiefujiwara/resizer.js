ImageRGBA = require './image-rgba'

class Resizer
  before: null

  constructor:(@before) ->

  scale:(width,height) ->
    scaleWidth  = parseFloat width  / @before.width
    scaleHeight = parseFloat height / @before.height
    if scaleWidth > scaleHeight then scaleWidth else scaleHeight

  resize:(width,height) ->
    scale  = @scale width,height
    width  = parseInt @before.width  * scale
    height = parseInt @before.height * scale
    after  = new ImageRGBA()
    after.initialize width,height, new Array(width * height * 4)

    for yAfter in [0..height-1]
      for xAfter in [0..width-1]
        xBefore = parseInt Math.round(xAfter / scale)
        yBefore = parseInt Math.round(yAfter / scale)
        xBefore = @before.width  - 1 unless xBefore < @before.width
        yBefore = @before.height - 1 unless yBefore < @before.height
        after.pixcel xAfter,yAfter, @before.pixcel(xBefore,yBefore)

    after

module.exports = Resizer
