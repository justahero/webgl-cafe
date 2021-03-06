namespace 'Cafe', (exports) ->
  class exports.Context
    constructor: (@canvas) ->
      @gl = @_initGlContext(canvas)
      window.onresize = @_resizeCanvas
      @_resizeCanvas()

    setViewport: (x, y, width, height) ->
      @gl.viewport(x, y, width, height)

    aspect: () ->
      @canvas.width / @canvas.height

    clearBuffer: (color = Cafe.Color.WHITE) ->
      @gl.clearColor(color.red, color.green, color.blue, color.alpha)
      @gl.enable(@gl.DEPTH_TEST)
      @gl.clear(@gl.COLOR_BUFFER_BIT)

    useProgram: (program) ->
      @gl.useProgram(program.program)

    _initGlContext: (canvas) ->
      try
        gl = canvas.getContext('experimental-webgl') || canvas.getContext('webgl')
      catch e
        alert("Unable to initialize WebGl")
      gl

    _resizeCanvas: () =>
      @canvas.width  = window.innerWidth
      @canvas.height = window.innerHeight
      @setViewport(0, 0, @canvas.width, @canvas.height)
