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

      return if _.isEmpty(vertices)

      sites = @_sortSites(vertices)
      @queue.init(sites)

      # @edgeList.
      sites_count = 0
      root        = sites[sites_count++]
      newsite     = sites[sites_count++]
      newintstar  = null

      while true
        if !@queue.empty
          newintstar = @queue.min
        if sites_count < sites.length && (@queue.empty || @_compare(newsite, newintstar))
          @_handleSiteEvent(newsite, root)
          newsite = sites[sites_count++]
        else if !@queue.empty
          lbnd = @queue.extractMin
          @_handleCircleEvent(lbnd, root)
        else
          break

      []

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


    _handleCircleEvent: (lbnd, root) ->
      debugger
      "teest"
