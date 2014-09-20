#= require helpers/namespace

namespace 'Primitives', (exports) ->
  class exports.Cube
    constructor: (size, position = vec3.create()) ->
      # TODO
