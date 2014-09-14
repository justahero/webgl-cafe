root = exports ? this

class GlContext
  constructor: (canvas) ->
    @gl = @_initGlContext(canvas)

  _initGlContext: (canvas) ->
    try
      gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl')
    catch e
      alert("Unable to initialize WebGl")
    gl

root.GlContext = GlContext
