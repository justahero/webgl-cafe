namespace 'Voronoi', (exports) ->
  class exports.PriorityQueue
    constructor: (comparison) ->
      @hash = []
      @comparison

    boundaries: (sites) ->
      xmin = 0.0
      xmax = 0.0
      ymin = 0.0
      ymax = 0.0

      for site in sites
        xmin = Math.min(xmin, site.x)
        xmax = Math.max(xmax, site.x)
        ymin = _.first(sites).y
        ymax = _.last(sites).y

      new Cafe.Rect(xmin, ymin, xmax, ymax)

    init: (sites) ->
      @bounds = @boundaries(sites)

    release: (halfedge) ->
      if halfedge.vertex != null
        index = @hash.indexOf(halfedge)
        @hash.splice(index, 1)
        halfedge.vertex = null

    insert: (halfedge, point, offset) ->
      debugger
      halfedge.vertex = { x: point.x, y: point.y }
      halfedge.ystar  = point.y + offset
      @hash.push(halfedge)
      @hash = @hash.sort(@comparison)

    empty: ->
      _.isEmpty(@hash)

    min: ->
      first = _.first(@hash)
      { x: first.vertex.x, y: first.ystar }

    extractMin: ->
      edge = _.first(@hash)
      @hash.shift
      edge
