namespace 'Cafe', (exports) ->
  class exports.Color
    @WHITE = new Color(1.0, 1.0, 1.0, 1.0)
    @BLACK = new Color(0.0, 0.0, 0.0, 1.0)

    constructor: (@red, @green, @blue, @alpha = 1.0) ->
