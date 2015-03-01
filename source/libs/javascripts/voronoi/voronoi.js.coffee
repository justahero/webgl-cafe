namespace 'Voronoi', (exports) ->
  class exports.Main
    constructor: () ->
      @edges = []
      @queue = new Voronoi.PriorityQueue(
        (l, r) ->
          (l.ystar > r.ystar) || (l.ystar == r.ystar && l.vertex.x < r.vertex.x)
        )

    calculate: (vertices) ->
      @edges = []
      @queue.init(vertices)

      newintstar = 0
      root = _.first(vertices)

      while true
        unless @queue.empty
          newintstar = @queue.min
        break
