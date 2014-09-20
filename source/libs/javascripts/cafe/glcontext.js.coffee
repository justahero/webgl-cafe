class @GlContext
  constructor: (canvas) ->
    @gl = WebGLDebugUtils.makeDebugContext(@_initGlContext(canvas))

  setViewport: (x, y, width, height) ->
    @gl.viewport(x, y, width, height)

  clearBuffer: (color = GlColor.WHITE) ->
    @gl.clearColor(color.red, color.green, color.blue, color.alpha)
    @gl.enable(@gl.DEPTH_TEST)
    @gl.clear(@gl.COLOR_BUFFER_BIT)

  drawTriangles: (count, offset = 0) ->
    @gl.drawElements(@gl.TRIANGLES, count, @gl.UNSIGNED_SHORT, offset * 2)

  useProgram: (program) ->
    @gl.useProgram(program.program)

  _initGlContext: (canvas) ->
    try
      gl = canvas.getContext('experimental-webgl') || canvas.getContext('webgl')
    catch e
      alert("Unable to initialize WebGl")
    gl
