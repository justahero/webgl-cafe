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

    rotate: (angle, vec3) ->
      mat4.rotate(@values, @values, angle, vec3)
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
