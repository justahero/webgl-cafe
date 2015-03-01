namespace 'Voronoi', (exports) ->
  class exports.Edge
    constructor: (@point1, @point2) ->
      @a = 0.0
      @b = 0.0
      @c = 0.0
      @ep0 = 0
      @ep1 = 0
