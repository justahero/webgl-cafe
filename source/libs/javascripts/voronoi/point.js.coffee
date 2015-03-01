namespace 'Voronoi', (exports) ->
  class exports.Point
    constructor: (@x, @y) ->

    @subtract: (l, r) ->
      new Point(r.x - l.x, r.y - l.y)
