namespace 'Voronoi', (exports) ->
  class exports.Point
    constructor: (@x, @y) ->

    @subtract: (l, r) ->
      new Point(r.x - l.x, r.y - l.y)

    @dot: (l, r) ->
      l.x * r.x + l.y * r.y

    dot: ->
      @x * @x + @y * @y
