namespace 'Voronoi', (exports) ->
  class exports.EdgeList
    constructor: () ->
      @leftEnd  = new Voronoi.HalfEdge(null, 'left')
      @rightEnd = new Voronoi.HalfEdge(null, 'left')
      @leftEnd.setRight(@rightEnd)
      @rightEnd.setLeft(@leftEnd)

    leftbnd: (p) ->
      halfedge = @leftEnd

      if (halfedge == @leftEnd) || (halfedge != @rightEnd && halfedge.rightOf(p))
        loop
          halfedge = halfedge.right
          break if halfedge != @rightEnd && halfedge.rightOf(p)
        halfedge = halfedge.left
      else
        loop
          halfedge = halfedge.left
          break if halfedge != @leftEnd && !halfedge.rightOf(p)

      halfedge
