class @Program
  constructor: (@gl, @vertexShader, @fragmentShader) ->
    @program = null
    @_link()

  getAttribLocation: (attribName) ->
    @gl.getAttribLocation(@program, attribName)

  _link: () ->
    @program = @gl.createProgram()
    @gl.attachShader(@program, @vertexShader.shader)
    @gl.attachShader(@program, @fragmentShader.shader)
    @gl.linkProgram(@program)

    unless @gl.getProgramParameter(@program, @gl.LINK_STATUS)
      error = @gl.getProgramInfoLog(@program)
      throw "Could not compile program, error: #{error}"

    @program
