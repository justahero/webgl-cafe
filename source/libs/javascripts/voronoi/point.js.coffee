namespace 'Voronoi', (exports) ->
  class exports.Point
    constructor: (@x, @y) ->

    @subtract: (l, r) ->
      new Point(r.x - l.x, r.y - l.y)

    @dot: (l, r) ->
      l.x * r.x + l.y * r.y

    @distance: (l, r) ->
      tx = r.x - l.x
      ty = r.y - l.y
      Math.sqrt(tx * tx + ty * ty)

    dot: ->
      @x * @x + @y * @y
