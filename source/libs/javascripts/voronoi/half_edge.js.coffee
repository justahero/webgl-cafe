namespace 'Voronoi', (exports) ->
  class exports.HalfEdge
    constructor: (edge = null, orientation = 'left') ->
      @left        = null
      @right       = null
      @edge        = edge
      @orientation = orientation
      @vertex      = 0
      @ystar       = 0

    release: ->
      assert @left != null
      assert @right != null
