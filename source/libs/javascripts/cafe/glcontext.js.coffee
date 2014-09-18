class @GlContext
  constructor: (canvas) ->
    @gl = WebGLDebugUtils.makeDebugContext(@_initGlContext(canvas))

  setViewport: (x, y, width, height) ->
    @gl.viewport(x, y, width, height)

  clearBuffer: (color = GlColor.WHITE) ->
    @gl.clearColor(color.red, color.green, color.blue, color.alpha)
    @gl.clear(@gl.COLOR_BUFFER_BIT)

  useProgram: (program) ->
    @gl.useProgram(program.program)

  _initGlContext: (canvas) ->
    try
      gl = canvas.getContext('experimental-webgl') || canvas.getContext('webgl')
    catch e
      alert("Unable to initialize WebGl")
    gl
