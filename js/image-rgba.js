(function() {
  var ImageRGBA, typeIsArray;

  typeIsArray = function(value) {
    return value && typeof value === 'object' && value instanceof Array && typeof value.length === 'number' && typeof value.splice === 'function' && !(value.propertyIsEnumerable('length'));
  };

  ImageRGBA = (function() {
    ImageRGBA.prototype.width = 0;

    ImageRGBA.prototype.height = 0;

    ImageRGBA.prototype.data = [];

    function ImageRGBA() {}

    ImageRGBA.prototype.initialize = function(width, height, data) {
      width = parseInt(width);
      height = parseInt(height);
      if (!typeIsArray(data)) {
        throw new Error('data should be an Array');
      }
      if (0 !== data.length % 4) {
        throw new Error('data should be an Array(4x)');
      }
      if (width * height * 4 !== data.length) {
        throw new Error('width,height should be matched with data');
      }
      this.width = width;
      this.height = height;
      this.data = data;
      return this;
    };

    ImageRGBA.prototype.pixcel = function(x, y, data) {
      var base;
      if (data == null) {
        data = null;
      }
      if (!(x < this.width && y < this.height)) {
        throw new Error("x and y should be in " + this.width + "x" + this.height);
      }
      base = y * this.width * 4 + x * 4;
      if (null !== data) {
        if (!typeIsArray(data)) {
          throw new Error('data should be an Array');
        }
        if (4 !== data.length) {
          throw new Error('data should be an Array(4)');
        }
        this.data[base] = data[0];
        this.data[base + 1] = data[1];
        this.data[base + 2] = data[2];
        this.data[base + 3] = data[3];
      }
      return [this.data[base++], this.data[base++], this.data[base++], this.data[base++]];
    };

    return ImageRGBA;

  })();

  module.exports = ImageRGBA;

}).call(this);
