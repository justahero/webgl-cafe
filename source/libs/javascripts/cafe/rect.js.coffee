namespace 'Cafe', (exports) ->
  class exports.Rect
    constructor: (@x, @y, @w, @h) ->

    left: ->
      @x

    top: ->
      @y

    right: ->
      @x + @w

    bottom: ->
      @y + @h

    width: ->
      @w

    height: ->
      @h

    empty: ->
      @w == 0 || @h == 0

    isInside: (x, y) ->
      @x >= x && y >= @y && x < right && y < bottom
