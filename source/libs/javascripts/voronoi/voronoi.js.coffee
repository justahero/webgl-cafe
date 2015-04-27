namespace 'Voronoi', (exports) ->
  class exports.Main
    constructor: () ->
      @edgeList = new Voronoi.EdgeList
      @queue = new Voronoi.PriorityQueue(
        (l, r) ->
          (l.ystar < r.ystar) || (l.ystar == r.ystar && l.vertex.x < r.vertex.x)
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

        if (sites_count < sites.length) && (@queue.empty() || @_compare(newsite, newintstar))
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
      points = _.map(vertices, (v) -> new Voronoi.Point(v.x, v.y))
      points.sort(@_compare)
      points

    _compare: (a, b) ->
      if a.y == b.y then a.x < b.x else a.y < b.y

    _handleSiteEvent: (newsite, root) ->
      assert(newsite != null)

      lbnd   = @edgeList.leftbnd(newsite)
      rbnd   = lbnd.right
      bottom = lbnd.rightreg(root)

      edge = Voronoi.Geometry.bisect(bottom, newsite)

      bisector = @_replaceEdge(edge, lbnd, bottom, 0)
      @_insertEdge(edge, bisector, rbnd, newsite)

    _replaceEdge: (edge, left, bottom, orientation) ->
      assert(edge != null)
      assert(left != null)
      assert(bottom != null)

      bisector = new Voronoi.HalfEdge(edge, orientation)
      left.insert(bisector)

      bp = new Voronoi.Point(0, 0)
      if Voronoi.Geometry.intersect(left, bisector, bp)
        @queue.release(left)
        @queue.insert(left, bp, Voronoi.Point.distance(bp, bottom))

      bisector

    _insertEdge: (edge, left, right, bottom) ->
      assert(edge != null)
      assert(left != null)

      bisector = new Voronoi.HalfEdge(edge, 1)
      left.insert(bisector)

      bp = new Voronoi.Point(0, 0)
      if Voronoi.Geometry.intersect(bisector, right, bp)
        @queue.insert(bisector, bp, Voronoi.Point.distance(bp, bottom))

      bisector

    _handleCircleEvent: (lbnd, root) ->
      assert(lbnd != null)

      llbnd = lbnd.left
      rbnd  = lbnd.right
      rrbnd = rbnd.right

      bottom = lbnd.leftreg(root)
      top    = rbnd.rightreg(root)
      v      = lbnd.vertex

      @_endPoint(lbnd.edge, lbnd.orientation, v)
      @_endPoint(rbnd.edge, rbnd.orientation, v)

      lbnd.release()
      rbnd.release()
      @queue.release(rbnd)

      pm = 0
      if bottom.y > top.y
        temp = bottom
        bottom = top
        top = temp
        pm = 1

      edge = Voronoi.Geometry.bisect(bottom, top)
      bisector = @_replaceEdge(edge, llbnd, bottom, pm)
      @_endPoint(edge, 1 - pm, v)

      bp = new Voronoi.Point(0, 0)
      if Voronoi.Geometry.intersect(bisector, rrbnd, bp)
        @queue.insert(bisector, bp, Voronoi.Point.distance(bp, bottom))

    _endPoint: (edge, orientation, s) ->
      assert(edge != null)
      assert(s != null)

      edge.ep[orientation] = new Voronoi.Point(s.x, s.y)
      if edge.ep[1 - orientation] == null
        return

      edge
