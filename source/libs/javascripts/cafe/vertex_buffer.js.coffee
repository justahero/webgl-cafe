class @VertexBuffer
  constructor: (@gl, vertices, numTriangles) ->
    @size   = 0
    @buffer = null
    @_initialize(vertices, numTriangles)

  render: (positionLocation) ->
    @gl.enableVertexAttribArray(positionLocation)
    @gl.vertexAttribPointer(positionLocation, @size, @gl.FLOAT, false, 0, 0)
    @gl.drawArrays(@gl.TRIANGLES, 0, @size * 3)

  _initialize: (vertices, numTriangles) ->
    @size = numTriangles
    @buffer = @gl.createBuffer()
    @gl.bindBuffer(@gl.ARRAY_BUFFER, @buffer)
    @gl.bufferData(@gl.ARRAY_BUFFER, vertices, @gl.STATIC_DRAW)
