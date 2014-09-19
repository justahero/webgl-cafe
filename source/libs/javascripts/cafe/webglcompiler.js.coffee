# Most of the functionality is taken from the great WebGL introduction by thoughtbot
# -> robots.thoughtbot.com/an-introduction-to-webgl
#

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
    new Shader(@gl, shaderSource, shaderType)

  _createProgram: (vertexShader, fragmentShader) ->
    new Program(@gl, vertexShader, fragmentShader)
