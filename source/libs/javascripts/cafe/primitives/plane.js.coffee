namespace 'Cafe.Primitives', (exports) ->
  class exports.Plane
    @create: (xsize = 1.0, ysize = 1.0) ->
      new Plane(xsize, ysize)

    constructor: (xsize, ysize) ->
      @vertices  = @_createVertices(xsize, ysize)
      @texcoords = @_createTextureCoords()
      @normals   = @_createNormals()
      @indices   = @_createIndices()

    _createVertices: (xsize, ysize) ->
      vertices = new Float32Array([
        -xsize, -xsize,  xsize,
         xsize, -xsize,  xsize,
         xsize,  xsize,  xsize,
        -xsize,  xsize,  xsize,
      ])

    _createTextureCoords: ->
      textureCoordinates = new Float32Array([
        0.0,  0.0,
        1.0,  0.0,
        1.0,  1.0,
        0.0,  1.0,
      ])

    _createNormals: ->
      normals = new Float32Array([
         0.0,  0.0,  1.0,
         0.0,  0.0,  1.0,
         0.0,  0.0,  1.0,
         0.0,  0.0,  1.0,
      ])

    _createIndices: ->
      indices = new Uint16Array([ 0, 1, 2, 0, 2, 3 ])
