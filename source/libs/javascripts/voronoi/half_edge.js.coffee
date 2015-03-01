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

    left: ->
      @left

    right: ->
      @right

    setLeft: (left) ->
      @left = left

    setRight: (right) ->
      @right = right

    edge: ->
      @edge

    isLeftEdge: ->
      @orientation == 'left'

    isRightEdge: ->
      !@isLeftEdge

    orientation: ->
      @orientation

    leftreg: (root) ->
      if @edge == null
        root
      else
        @edge.reg[@orientation]

    rightreg: (root) ->
      if @edge == null
        root
      else
        @edge.reg[@orientation]

    insert: (insert) ->
      insert.left  = this
      insert.right = @right
      @right.left  = insert
      @right = insert

    rightOf: (p) ->
      # TODO
