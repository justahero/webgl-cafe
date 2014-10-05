namespace 'Cafe', (exports) ->
  class exports.Matrix3
    @fromMat4Rot: (matrix) ->
      result = new Cafe.Matrix3()
      matrix.toMat3Rot(result)

    constructor: () ->
      @values = mat3.create()
