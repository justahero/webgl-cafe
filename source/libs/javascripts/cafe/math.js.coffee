namespace 'Cafe', (exports) ->
  class exports.Math
    @gradToRad: (grad) ->
      (Math.PI * grad) / 180.0
