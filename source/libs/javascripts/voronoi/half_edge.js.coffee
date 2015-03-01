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
      debugger
      fast    = false
      above   = false
      topsite = @edge.reg['right']
      right_of_site = p.x > topsite.x

      if right_of_site && @isLeftEdge
        return true
      if !right_of_site && @isRightEdge
        return false

      if @edge.a == 1.0
        d = Voronoi.Point.subtract(topsite, p)
        if (!right_of_site & (edge.b < 0.0)) || (right_of_site & (edge.b >= 0.0))
          fast  = (d.y >= (edge.b * d.x))
          above = fast
        else
          above = (p.x + p.y * edge.b) > edge.c
          if edge.b < 0.0
            above = !above
          if !above
            fast = true
      else
        yl = edge.c - edge.a * p.x
        t1 = p.y - yl
        t2 = p.x - topsite.x
        t3 = yl  - topsite.y
        above = ((t1 * t1) > ((t2 * t2) + (t3 * t3)))

      @isLeftEdge == above
