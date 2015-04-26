namespace 'Voronoi', (exports) ->
  class exports.PriorityQueue
    constructor: (@comparison) ->
      @hash = []

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
        index = @hash.indexOf(halfedge)
        @hash.splice(index, 1)
        halfedge.vertex = null

    insert: (halfedge, v, offset) ->
      halfedge.vertex = { x: v.x, y: v.y }
      halfedge.ystar  = v.y + offset
      @hash.push(halfedge)
      @hash = @hash.sort(@comparison)

    empty: ->
      @hash.length == 0

    min: ->
      first = @hash[0]
      { x: first.vertex.x, y: first.ystar }

    extractMin: ->
      edge = _.first(@hash)
      @hash.shift
      edge
