namespace 'Cafe', (exports) ->
  class exports.Mesh
    @create: (context, primitive) ->
      mesh = new Cafe.Mesh()
      mesh.addVertexBuffer('vertexPos', new Cafe.VertexBuffer(context.gl, primitive.vertices, 3))
      mesh.addVertexBuffer('texCoord',  new Cafe.VertexBuffer(context.gl, primitive.texcoords, 2))
      mesh.addVertexBuffer('normalPos', new Cafe.VertexBuffer(context.gl, primitive.normals, 3))
      mesh.setIndexBuffer(new Cafe.IndexBuffer(context.gl, primitive.indices))
      mesh

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
