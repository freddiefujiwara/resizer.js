typeIsArray = ( value ) ->
  value and
    typeof value is 'object' and
    value instanceof Array   and
    typeof value.length is 'number' and
    typeof value.splice is 'function' and
    not ( value.propertyIsEnumerable 'length' )

class ImageRGBA
  width:0
  height:0
  data:[]

  constructor:() ->

  initialize:(width,height,data) ->
    width  = parseInt(width)
    height = parseInt(height)
    throw new Error('data should be an Array')                  unless typeIsArray data
    throw new Error('data should be an Array(4x)')              unless 0 == data.length % 4
    throw new Error('width,height should be matched with data') unless width*height*4 == data.length
    @width  = width
    @height = height
    @data   = data
    @

  pixcel:(x,y,data = null) ->
    throw new Error "x and y should be in #{@width}x#{@height}" unless x < @width and y  < @height
    base = y * @width * 4 + x * 4
    unless null == data
      throw new Error('data should be an Array')    unless typeIsArray data
      throw new Error('data should be an Array(4)') unless 4 == data.length
      @data[base    ] = data[0]
      @data[base + 1] = data[1]
      @data[base + 2] = data[2]
      @data[base + 3] = data[3]

    [@data[base++],@data[base++],@data[base++],@data[base++]]

module.exports = ImageRGBA
