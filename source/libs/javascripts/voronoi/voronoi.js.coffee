namespace 'Voronoi', (exports) ->
  class exports.Main
    constructor: () ->
      @edgeList = new Voronoi.EdgeList
      @queue = new Voronoi.PriorityQueue(
        (l, r) ->
          (l.ystar > r.ystar) || (l.ystar == r.ystar && l.vertex.x < r.vertex.x)
        )

    calculate: (vertices) ->
      unless vertices instanceof Array
        throw "Vertices is not an Array"

      return [] if vertices.length == 0

      sites = @_sortSites(vertices)
      @queue.init(sites)

      sites_count = 0
      root        = sites[sites_count++]
      newsite     = sites[sites_count++]
      newintstar  = null

      while true
        if !@queue.empty()
          newintstar = @queue.min()

        if sites_count < sites.length && (@queue.empty() || @_compare(newsite, newintstar))
          @_handleSiteEvent(newsite, root)
          newsite = sites[sites_count++]
        else if !@queue.empty()
          lbnd = @queue.extractMin()
          @_handleCircleEvent(lbnd, root)
        else
          break

      # Return the list of edges
      result = []
      lbnd = @edgeList.leftEnd.right
      while lbnd != @edgeList.rightEnd
        result.push(lbnd.edge)
        lbnd = lbnd.right

      result

    _sortSites: (vertices) ->
      points = _.map(vertices, (v) -> {x: v.x, y: v.y})
      points.sort(@_compare)

    _compare: (l, r) ->
      if l.y == r.y then l.x > r.x else l.y > r.y

    _handleSiteEvent: (newsite, root) ->
      lbnd   = @edgeList.leftbnd(newsite)
      rbnd   = lbnd.right
      bottom = lbnd.rightreg(root)

      edge = Voronoi.Geometry.bisect(bottom, newsite)

      bisector = @_replaceEdge(edge, lbnd, bottom, 'left')
      @_insertEdge(edge, bisector, rbnd, newsite)

    _replaceEdge: (edge, left, bottom, orientation) ->
      assert(edge != null)
      assert(left != null)
      assert(bottom != null)

      bisector = new Voronoi.HalfEdge(edge, orientation)
      left.insert(bisector)

      bp = { x: 0, y: 0 }
      if Voronoi.Geometry.intersect(left, bisector, bp)
        @queue.release(left)
        @queue.insert(left, bp, Voronoi.Point.distance(bp, bottom))

      bisector

    _insertEdge: (edge, left, right, bottom) ->
      assert(edge != null)
      assert(left != null)

      bisector = new Voronoi.HalfEdge(edge, 'right')
      left.insert(bisector)

      bp = { x: 0, y: 0 }
      if Voronoi.Geometry.intersect(bisector, right, bp)
        @queue.insert(bisector, bp, Voronoi.Point.distance(bp, bottom))

      bisector

    _handleCircleEvent: (lbnd, root) ->
      assert(lbnd != null)

      rbnd   = lbnd.right
      bottom = lbnd.leftreg(root)
      top    = lbnd.rightreg(root)

      @_finishEdge(lbnd, rbnd)
      @queue.release(rbnd)

      pm = 'left'
      if bottom.y > top.y
        temp = bottom
        bottom = top
        top = temp
        pm = 'right'

      edge = Voronoi.Geometry.bisect(bottom, top)
      @_endPoint(edge, pm == 'left' ? 'right' : 'left', lbnd.vertex)

      llbnd = lbnd.left
      rrbnd = rbnd.right
      bisector = @_replaceEdge(edge, llbnd, bottom, pm)

      bp = { x: 0, y: 0 }
      if Voronoi.Geometry.intersect(bisector, rrbnd, bp)
        @queue.insert(bisector, bp, Voronoi.Point.distance(bp, bottom))

    _finishEdge: (left, right) ->
      assert(left != null)
      assert(right != null)

      v = left.vertex

      @_endPoint(left.edge, left.orientation, v)
      @_endPoint(right.edge, right.orientation, v)

      left.release()
      right.release()

    _endPoint: (edge, orientation, s) ->
      assert(edge != null)
      assert(s != null)

      if orientation == 'left'
        edge.ep0 = new Voronoi.Point(s.x, s.y)
        return if edge.ep1 == null
      else
        edge.ep1 = new Voronoi.Point(s.x, s.y)
        return if edge.ep0 == null

      edge
