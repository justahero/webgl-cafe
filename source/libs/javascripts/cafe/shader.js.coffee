namespace 'Cafe', (exports) ->
  class exports.Shader
    constructor: (@gl, @source, @type) ->
      @shader = null
      @_compile()

    _compile: () ->
      # console.log("Comiling shader: \n#{@source}")
      @shader = @gl.createShader(@type)
      @gl.shaderSource(@shader, @source)
      @gl.compileShader(@shader)

      unless @gl.getShaderParameter(@shader, @gl.COMPILE_STATUS)
        error = @gl.getShaderInfoLog(@shader)
        throw "Could not compile shader, error: #{error}"

      @shader
