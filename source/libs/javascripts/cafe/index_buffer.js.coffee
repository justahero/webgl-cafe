namespace 'Cafe', (exports) ->
  class exports.IndexBuffer
    constructor: (@gl, indices) ->
      @size   = 0
      @buffer = null
      @_initialize(indices)

    _initialize: (indices) ->
      @size = indices.length
      @buffer = @gl.createBuffer()
      @gl.bindBuffer(@gl.ELEMENT_ARRAY_BUFFER, @buffer)
      @gl.bufferData(@gl.ELEMENT_ARRAY_BUFFER, indices, @gl.STATIC_DRAW)
