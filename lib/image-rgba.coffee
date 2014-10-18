class ImageRGBA
  width:0
  height:0
  data:[]

  constructor:() ->

  initialize:(width,height,data) ->
    width  = parseInt(width)
    height = parseInt(height)
    typeIsArray = ( value ) ->
      value and
        typeof value is 'object' and
        value instanceof Array   and
        typeof value.length is 'number' and
        typeof value.splice is 'function' and
        not ( value.propertyIsEnumerable 'length' )
    throw new Error('data should be an Array')                  unless typeIsArray data
    throw new Error('data should be an Array(4x)')              unless 0 == data.length % 4
    throw new Error('width,height should be matched with data') unless width*height*4 == data.length
    @width  = width
    @height = height
    @data   = data
    @

module.exports = ImageRGBA
