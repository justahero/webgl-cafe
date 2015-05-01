namespace 'Voronoi', (exports) ->
  class exports.Main
    constructor: () ->
      @edgeList = new Voronoi.EdgeList()
      @queue = new Voronoi.PriorityQueue()
      @edges = []

    _compare: (a, b) ->
      if a.y == b.y then a.x < b.x else a.y < b.y

    calculate: (vertices) ->
      unless vertices instanceof Array
        throw "Vertices is not an Array"

      return [] if vertices.length == 0

      sites = @_sortSites(vertices)
      @queue.init(sites)
      @edges = []
      @edgeList = new Voronoi.EdgeList()

      sites_count = 0
      root        = sites[sites_count++]
      newsite     = sites[sites_count++]
      newintstar  = new Voronoi.Point(0, 0)

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
      lbnd = @edgeList.leftEnd.right
      while lbnd isnt @edgeList.rightEnd
        @_clipLine(lbnd.edge)
        lbnd = lbnd.right

      @edges

    _sortSites: (vertices) ->
      points = _.map(vertices, (v) -> new Voronoi.Point(v.x, v.y))
      points = points.sort(
        (a, b) ->
          if a.y == b.y then a.x - B.x else a.y - b.y
        )
      points

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

    _endPoint: (e, lr, s) ->
      assert(e != null)
      assert(s != null)
      assert(lr >= 0 && lr <= 1)

      e.ep[lr] = new Voronoi.Point(s.x, s.y)
      if e.ep[1 - lr] == null
        return
      @_clipLine(e)

    _addEdge: (x1, y1, x2, y2) ->
      @edges.push({ x: x1, y: y1 })
      @edges.push({ x: x2, y: y2 })

    _clipLine: (e) ->
      bounds = @queue.bounds

      pxmin = bounds.left()
      pxmax = bounds.right()
      pymin = bounds.top()
      pymax = bounds.bottom()
      s1 = s2 = null
      x1 = x2 = y1 = y2 = 0.0

      if e.a == 1.0 && e.b >= 0.0
        s1 = e.ep[1];
        s2 = e.ep[0];
      else
        s1 = e.ep[0];
        s2 = e.ep[1];

      if e.a == 1.0
        y1 = pymin
        if s1 != null && s1.y > pymin
          y1 = s1.y
        if y1 > pymax
          return null

        x1 = e.c - e.b * y1
        y2 = pymax
        if s2 != null && s2.y < pymax
          y2 = s2.y
        if y2 < pymin
          return null

        x2 = e.c - e.b * y2

        if ((x1 > pxmax) && (x2 > pxmax)) || ((x1 < pxmin) && (x2 < pxmin))
          return null;

        if x1 > pxmax
          x1 = pxmax
          y1 = (e.c - x1) / e.b

        if x1 < pxmin
          x1 = pxmin
          y1 = (e.c - x1) / e.b

        if x2 > pxmax
          x2 = pxmax
          y2 = (e.c - x2) / e.b

        if x2 < pxmin
          x2 = pxmin
          y2 = (e.c - x2) / e.b

      else
        x1 = pxmin
        if s1 != null && s1.x > pxmin
          x1 = s1.x
        if x1 > pxmax
          return null

        y1 = e.c - e.a * x1
        x2 = pxmax
        if s2 != null && s2.x < pxmax
          x2 = s2.x
        if x2 < pxmin
          return null

        y2 = e.c - e.a * x2

        if ((y1 > pymax) && (y2 > pymax)) || ((y1 < pymin) && (y2 < pymin))
          return null

        if y1 > pymax
          y1 = pymax
          x1 = (e.c - y1) / e.a
        if y1 < pymin
          y1 = pymin
          x1 = (e.c - y1) / e.a
        if y2 > pymax
          y2 = pymax
          x2 = (e.c - y2) / e.a
        if y2 < pymin
          y2 = pymin
          x2 = (e.c - y2) / e.a

      @_addEdge(x1, y1, x2, y2)
