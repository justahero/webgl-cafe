class @WebGlCompiler
  constructor: (@gl, @shaders) ->

  createProgramWithShaders: (vertexShaderName, pixelShaderName) ->
    vertexShader = @_createShader(vertexShaderName, @gl.VERTEX_SHADER)
    pixelShader  = @_createShader(pixelShaderName, @gl.FRAGMENT_SHADER)
    @_createProgram(vertexShader, pixelShader)

  _createShader: (shaderName, shaderType) ->
    shaderSource = @shaders["#{shaderName}"]
    unless shaderSource
      throw "Shader not found: #{shaderName}"
    @_compileShader(shaderSource, shaderType)

  _compileShader: (shaderSource, shaderType) ->
    shader = @gl.createShader(shaderType)
    @gl.shaderSource(shader, shaderSource)
    @gl.compileShader(shader)

    unless @gl.getShaderParameter(shader, @gl.COMPILE_STATUS)
      error = @gl.getShaderInfoLog(shader)
      throw "Could not compile shader, error: #{error}"

    shader

  _createProgram: (vertexShader, fragmentShader) ->
    program = @gl.createProgram()
    @gl.attachShader(program, vertexShader)
    @gl.attachShader(program, fragmentShader)
    @gl.linkProgram(program)

    unless @gl.getProgramParameter(program, @gl.LINK_STATUS)
      error = @gl.getProgramInfoLog(program)
      throw "Could not compile program, error: #{error}"

    program