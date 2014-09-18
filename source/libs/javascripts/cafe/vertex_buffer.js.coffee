class @VertexBuffer
  constructor: (@gl, vertices) ->
    @size   = 0
    @buffer = null
    @_initialize(vertices)

  _initialize: (vertices) ->
    @size = vertices.length
    @buffer = @gl.createBuffer()
    @gl.bindBuffer(@gl.ARRAY_BUFFER, @buffer)
    @gl.bufferData(@gl.ARRAY_BUFFER, vertices, @gl.STATIC_DRAW)
