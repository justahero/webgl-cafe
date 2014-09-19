class @Program
  constructor: (@gl, @vertexShader, @fragmentShader) ->
    @program = null
    @_link()

  getAttribLocation: (attribName) ->
    location = @gl.getAttribLocation(@program, attribName)
    if location == -1
       throw "Could not getAttribLocation for #{attribName}"
    location

  uniformLocation: (attribName) ->
    location = @gl.getUniformLocation(@program, attribName)
    if location == -1
       throw "Could not getUniformLocation for #{attribName}"
    location

  _link: () ->
    @program = @gl.createProgram()
    @gl.attachShader(@program, @vertexShader.shader)
    @gl.attachShader(@program, @fragmentShader.shader)
    @gl.linkProgram(@program)

    unless @gl.getProgramParameter(@program, @gl.LINK_STATUS)
      error = @gl.getProgramInfoLog(@program)
      throw "Could not compile program, error: #{error}"

    @program
