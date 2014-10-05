namespace 'Cafe', (exports) ->
  class exports.Matrix4
    @identity = () ->
      new Cafe.Matrix4()

    constructor: () ->
      @values = mat4.create()
      @identity()

    set: (matrix) ->
      mat4.copy(@values, matrix.values)
      this

    identity: ->
      mat4.identity(@values)
      this

    perspective: (fov, aspect, near, far) ->
      mat4.perspective(@values, fov, aspect, near, far)
      this

    rotate: (rad, vec3) ->
      mat4.rotate(@values, @values, rad, vec3)
      this

    rotateX: (rad) ->
      mat4.rotateX(@values, @values, rad)
      this

    rotateY: (rad) ->
      mat4.rotateY(@values, @values, rad)
      this

    translate: (vec3) ->
      mat4.translate(@values, @values, vec3)
      this

    invert: () ->
      mat4.invert(@values, @values)
      this

    transpose: () ->
      mat4.transpose(@values, @values)
      this

    toMat3Rot: (dest) ->
      dst = dest.values
      src = @values

      a00 = src[0]; a01 = src[1]; a02 = src[2]
      a10 = src[4]; a11 = src[5]; a12 = src[6]
      a20 = src[8]; a21 = src[9]; a22 = src[10]

      b01 =  a22 * a11 - a12 * a21
      b11 = -a22 * a10 + a12 * a20
      b21 =  a21 * a10 - a11 * a20

      d = a00 * b01 + a01 * b11 + a02 * b21
      id = 1 / d

      dst[0] = b01 * id
      dst[3] = (-a22 * a01 + a02 * a21) * id
      dst[6] = ( a12 * a01 - a02 * a11) * id
      dst[1] = b11 * id
      dst[4] = ( a22 * a00 - a02 * a20) * id
      dst[7] = (-a12 * a00 + a02 * a10) * id
      dst[2] = b21 * id
      dst[5] = (-a21 * a00 + a01 * a20) * id
      dst[8] = ( a11 * a00 - a01 * a10) * id

      return dest
