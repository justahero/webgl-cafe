namespace 'Cafe', (exports) ->
  class exports.Mesh
    constructor: () ->
      @vertexBuffers = {}
      @indexBuffer   = null
      @modelMatrix   = mat4.create()

    addVertexBuffer: (name, vertexBuffer) ->
      @vertexBuffers[name] = vertexBuffer

    setIndexBuffer: (indexBuffer) ->
      @indexBuffer = indexBuffer

    bind: (program) ->
      for name, buffer in @vertexBuffers
        program.bindVertexBuffer(name, buffer)
      if @indexBuffer
        program.bindIndexBuffer(@indexBuffer)
