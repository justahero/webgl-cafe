namespace 'Cafe', (exports) ->
  class exports.Camera
    constructor: () ->
      @projection = new Cafe.Matrix4()
      @view       = new Cafe.Matrix4()

    perspective: (fov, aspect, near, far) ->
      @projection.perspective(fov, aspect, near, far)
