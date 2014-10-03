namespace 'Cafe', (exports) ->
  class exports.Mesh
    constructor: () ->
      @vertexBuffers = []
      @indexBuffer   = null
      @modelMatrix   = mat4.create()

    addVertexBuffer: (name, vertexBuffer) ->
      @vertexBuffers.push {name: name, buffer: vertexBuffer}

    setIndexBuffer: (indexBuffer) ->
      @indexBuffer = indexBuffer

    render: (context) ->
      context.drawTriangles(@indexBuffer.size)
