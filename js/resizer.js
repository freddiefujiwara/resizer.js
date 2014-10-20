(function() {
  var ImageRGBA, Resizer;

  ImageRGBA = require('../js/image-rgba.js');

  Resizer = (function() {
    Resizer.prototype.before = null;

    function Resizer(before) {
      this.before = before;
    }

    Resizer.prototype.scale = function(width, height) {
      var scaleHeight, scaleWidth;
      scaleWidth = parseFloat(width / this.before.width);
      scaleHeight = parseFloat(height / this.before.height);
      if (scaleWidth > scaleHeight) {
        return scaleWidth;
      } else {
        return scaleHeight;
      }
    };

    Resizer.prototype.resize = function(width, height) {
      var after, scale, xAfter, xBefore, yAfter, yBefore, _i, _j, _ref, _ref1;
      scale = this.scale(width, height);
      width = parseInt(this.before.width * scale);
      height = parseInt(this.before.height * scale);
      after = new ImageRGBA();
      after.initialize(width, height, new Array(width * height * 4));
      for (yAfter = _i = 0, _ref = height - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; yAfter = 0 <= _ref ? ++_i : --_i) {
        for (xAfter = _j = 0, _ref1 = width - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; xAfter = 0 <= _ref1 ? ++_j : --_j) {
          xBefore = parseInt(Math.round(xAfter / scale));
          yBefore = parseInt(Math.round(yAfter / scale));
          if (!(xBefore < this.before.width)) {
            xBefore = this.before.width - 1;
          }
          if (!(yBefore < this.before.height)) {
            yBefore = this.before.height - 1;
          }
          after.pixcel(xAfter, yAfter, this.before.pixcel(xBefore, yBefore));
        }
      }
      return after;
    };

    return Resizer;

  })();

  module.exports = Resizer;

}).call(this);
