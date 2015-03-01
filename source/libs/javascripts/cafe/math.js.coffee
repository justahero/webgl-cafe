namespace 'Cafe', (exports) ->
  class exports.MathHelpers
    @gradToRad: (grad) ->
      (Math.PI * grad) / 180.0

    @random: (min, max) ->
      Math.random() * (max - min) + min
