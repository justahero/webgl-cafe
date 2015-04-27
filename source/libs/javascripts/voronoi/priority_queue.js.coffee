namespace 'Voronoi', (exports) ->
  class exports.PriorityQueue
    constructor: ->
      @hash = []

    @comparison = (l, r) ->
      (l.ystar < r.ystar) || (l.ystar == r.ystar && l.vertex.x < r.vertex.x)

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

      new Cafe.Rect(xmin, ymin, xmax, ymax)

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
      @hash = @hash.sort(@comparison)

    empty: ->
      @hash.length == 0

    min: ->
      first = @hash[0]
      new Voronoi.Point(first.vertex.x, first.ystar)

    extractMin: ->
      edge = @hash[0]
      @hash.shift
      edge

    _erase: (halfedge) ->
      index = @hash.indexOf(halfedge)
      if index != -1
        @hash.splice(index, 1)
