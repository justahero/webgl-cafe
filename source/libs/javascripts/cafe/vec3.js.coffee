namespace 'Cafe', (exports) ->
  class exports.Vec3
    @fromValues = (x, y, z) ->
      new Cafe.Vec3(x, y, z)

    constructor: (x, y, z) ->
      @values = vec3.fromValues(x, y, z)

    normalize: ->
      vec3.normalize(@value, @values)
      this
