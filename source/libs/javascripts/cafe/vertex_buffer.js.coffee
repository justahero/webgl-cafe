class @VertexBuffer
  constructor: (@gl, vertices, item_size) ->
    @size      = 0
    @buffer    = null
    @item_size = item_size
    @_initialize(vertices)

  _initialize: (vertices) ->
    @size   = vertices.length / @item_size
    @buffer = @gl.createBuffer()
    @gl.bindBuffer(@gl.ARRAY_BUFFER, @buffer)
    @gl.bufferData(@gl.ARRAY_BUFFER, vertices, @gl.STATIC_DRAW)
