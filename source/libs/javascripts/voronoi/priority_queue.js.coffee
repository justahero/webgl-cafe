namespace 'Voronoi', (exports) ->
  class exports.PriorityQueue
    constructor: ->
      @hash = []

    @comparison = (l, r) ->
      if l.ystar == r.ystar
        l.vertex.x - r.vertex.x
      else
        l.ystar - r.ystar

    @boundaries: (sites) ->
      xmin = 0.0
      xmax = 0.0
      ymin = 0.0
      ymax = 0.0

      for site in sites
        xmin = Math.min(xmin, site.x)
        xmax = Math.max(xmax, site.x)

      if sites.length > 0
        ymin = sites[0].y
        ymax = sites[sites.length - 1].y

      { xmin: xmin, ymin: ymin, xmax: xmax, ymax: ymax }

    init: (sites) ->
      @bounds = PriorityQueue.boundaries(sites)

    release: (halfedge) ->
      if halfedge.vertex != null
        @_erase(halfedge)
        halfedge.vertex = null

    insert: (he, v, offset) ->
      he.vertex = new Voronoi.Point(v.x, v.y)
      he.ystar  = v.y + offset
      @hash.push(he)
      # possibly very slow, can be boiled down to (log N) instead of (N log N)
      @hash.sort(PriorityQueue.comparison)

    size: ->
      @hash.length

    empty: ->
      @hash.length == 0

    min: ->
      v = @hash[0]
      { x: v.vertex.x, y: v.ystar }

    extractMin: ->
      assert(@hash.length > 0)
      @hash.shift()

    _erase: (halfedge) ->
      index = @hash.indexOf(halfedge)
      if index != -1
        @hash.splice(index, 1)
