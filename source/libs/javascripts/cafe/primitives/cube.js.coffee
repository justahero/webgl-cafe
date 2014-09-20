namespace 'Cafe.Primitives', (exports) ->
  class exports.Cube
    @create: (size = 1.0) ->
      new Cube(size)

    constructor: (size, position) ->
      @vertices  = @_createVertices(size)
      @texcoords = @_createTextureCoords()
      @normals   = @_createNormals()
      @indices   = @_createIndices()

    _createVertices: (size) ->
      vertices = new Float32Array([
        -size, -size,  size,
         size, -size,  size,
         size,  size,  size,
        -size,  size,  size,

        -size, -size, -size,
        -size,  size, -size,
         size,  size, -size,
         size, -size, -size,

        -size,  size, -size,
        -size,  size,  size,
         size,  size,  size,
         size,  size, -size,

        -size, -size, -size,
         size, -size, -size,
         size, -size,  size,
        -size, -size,  size,

         size, -size, -size,
         size,  size, -size,
         size,  size,  size,
         size, -size,  size,

        -size, -size, -size,
        -size, -size,  size,
        -size,  size,  size,
        -size,  size, -size,
      ])

    _createTextureCoords: ->
      textureCoordinates = new Float32Array([
        0.0,  0.0,
        1.0,  0.0,
        1.0,  1.0,
        0.0,  1.0,

        0.0,  0.0,
        1.0,  0.0,
        1.0,  1.0,
        0.0,  1.0,

        0.0,  0.0,
        1.0,  0.0,
        1.0,  1.0,
        0.0,  1.0,

        0.0,  0.0,
        1.0,  0.0,
        1.0,  1.0,
        0.0,  1.0,

        0.0,  0.0,
        1.0,  0.0,
        1.0,  1.0,
        0.0,  1.0,

        0.0,  0.0,
        1.0,  0.0,
        1.0,  1.0,
        0.0,  1.0
      ])

    _createNormals: ->
      normals = new Float32Array([
         0.0,  0.0,  1.0,
         0.0,  0.0,  1.0,
         0.0,  0.0,  1.0,
         0.0,  0.0,  1.0,

         0.0,  0.0, -1.0,
         0.0,  0.0, -1.0,
         0.0,  0.0, -1.0,
         0.0,  0.0, -1.0,

         0.0,  1.0,  0.0,
         0.0,  1.0,  0.0,
         0.0,  1.0,  0.0,
         0.0,  1.0,  0.0,

         0.0, -1.0,  0.0,
         0.0, -1.0,  0.0,
         0.0, -1.0,  0.0,
         0.0, -1.0,  0.0,

         1.0,  0.0,  0.0,
         1.0,  0.0,  0.0,
         1.0,  0.0,  0.0,
         1.0,  0.0,  0.0,

        -1.0,  0.0,  0.0,
        -1.0,  0.0,  0.0,
        -1.0,  0.0,  0.0,
        -1.0,  0.0,  0.0,
      ])

    _createIndices: ->
      indices = new Uint16Array([
         0,  1,  2,    0,  2,  3,   # Front face
         4,  5,  6,    4,  6,  7,   # Back face
         8,  9, 10,    8, 10, 11,   # Top face
        12, 13, 14,   12, 14, 15,   # Bottom face
        16, 17, 18,   16, 18, 19,   # Right face
        20, 21, 22,   20, 22, 23    # Left face
      ])
