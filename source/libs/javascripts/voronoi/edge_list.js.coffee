namespace 'Voronoi', (exports) ->
  class exports.EdgeList
    constructor: () ->
      @leftEnd  = new Voronoi.HalfEdge()
      @rightEnd = new Voronoi.HalfEdge()
      @leftEnd.setRight(@rightEnd)
      @rightEnd.setLeft(@leftEnd)

    leftbnd: (p) ->
      halfedge = @leftEnd

      if (halfedge is @leftEnd) || ((halfedge isnt @rightEnd) && halfedge.rightOf(p))
        loop
          halfedge = halfedge.right
          break unless ((halfedge isnt @rightEnd) && halfedge.rightOf(p))
        halfedge = halfedge.left
      else
        loop
          halfedge = halfedge.left
          break unless ((halfedge isnt @leftEnd) && !halfedge.rightOf(p))

      halfedge
