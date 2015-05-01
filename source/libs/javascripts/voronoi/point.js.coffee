namespace 'Voronoi', (exports) ->
  class exports.Point
    constructor: (@x, @y) ->

    @subtract: (l, r) ->
      { x: r.x - l.x, y: r.y - l.y }

    @dot: (l, r) ->
      l.x * r.x + l.y * r.y

    @length: (x, y) ->
      Math.sqrt(x * x + y * y)

    @distance: (l, r) ->
      dx = r.x - l.x
      dy = r.y - l.y
      Math.sqrt(dx * dx + dy * dy)

    length: ->
      Math.sqrt(@dot)
