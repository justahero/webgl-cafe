namespace 'Cafe', (exports) ->
  class exports.Mesh
    @create: (context, primitive, with_texture = true) ->
      mesh = new Cafe.Mesh()
      mesh.addVertexBuffer('position', new Cafe.VertexBuffer(context.gl, primitive.vertices, 3))
      if with_texture
        mesh.addVertexBuffer('texCoord',  new Cafe.VertexBuffer(context.gl, primitive.texcoords, 2))
      mesh.addVertexBuffer('normal', new Cafe.VertexBuffer(context.gl, primitive.normals, 3))
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

    render: (gl, count, offset = 0) ->
      gl.drawElements(gl.TRIANGLES, count, gl.UNSIGNED_SHORT, offset * 2)

    rotate: (angle, vec3) ->
      mat4.rotate(@modelMatrix, @modelMatrix, angle, vec3)

    trans: (vec3) ->
      mat4.translate(@modelMatrix, @modelMatrix, vec3)
