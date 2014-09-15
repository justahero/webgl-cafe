class @GlColor
  @WHITE = new GlColor(1.0, 1.0, 1.0, 1.0)
  @BLACK = new GlColor(0.0, 0.0, 0.0, 1.0)

  constructor: (@red, @green, @blue, @alpha = 1.0) ->
