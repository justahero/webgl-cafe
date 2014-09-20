namespace 'Cafe', (exports) ->
  class exports.VertexBuffer
    constructor: (@gl, vertices, itemSize) ->
      @size      = 0
      @buffer    = null
      @itemSize = itemSize
      @_initialize(vertices)

    _initialize: (vertices) ->
      @size   = vertices.length / @itemSize
      @buffer = @gl.createBuffer()
      @gl.bindBuffer(@gl.ARRAY_BUFFER, @buffer)
      @gl.bufferData(@gl.ARRAY_BUFFER, vertices, @gl.STATIC_DRAW)
