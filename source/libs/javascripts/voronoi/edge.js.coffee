namespace 'Voronoi', (exports) ->
  class exports.Edge
    constructor: (@point1, @point2) ->
      @a = 0.0
      @b = 0.0
      @c = 0.0
      @reg = { 'left': point1, 'right': point2 }
      @ep0 = null
      @ep1 = null
