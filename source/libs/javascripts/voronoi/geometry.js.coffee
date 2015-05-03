namespace 'Voronoi', (exports) ->
  class exports.Geometry
    @bisect: (s1, s2) ->
      assert(s1 != null)
      assert(s2 != null)

      newedge = new Voronoi.Edge(s1, s2)
      d = Voronoi.Point.subtract(s1, s2)
      adx = Math.abs(d.x)
      ady = Math.abs(d.y)
      newedge.c = Voronoi.Point.dot(s1, d) + Voronoi.Point.dot(d, d) * 0.5

      if adx > ady
        newedge.a = 1.0
        newedge.b = d.y / d.x
        newedge.c /= d.x
      else
        newedge.b = 1.0
        newedge.a = d.x / d.y
        newedge.c /= d.y

      newedge

    @intersect: (el1, el2, bp) ->
      assert(el1 != null)
      assert(el2 != null)
      assert(bp  != null)

      e  = null
      e1 = el1.edge
      e2 = el2.edge

      if e1 == null || e2 == null
        return false

      if e1.reg[1] is e2.reg[1]
        return false

      d = (e1.a * e2.b) - (e1.b * e2.a)
      if Math.abs(d) < 0.0000001
        return false

      xint = (e1.c * e2.b - e2.c * e1.b) / d
      yint = (e2.c * e1.a - e1.c * e2.a) / d

      if (e1.reg[1].y < e2.reg[1].y) || ((e1.reg[1].y == e2.reg[1].y) && (e1.reg[1].x < e2.reg[1].x))
        el = el1
        e  = e1
      else
        el = el2
        e  = e2

      right_of_site = (xint >= e.reg[1].x)
      if (right_of_site && el.isLeftEdge()) || (!right_of_site && el.isRightEdge())
        return false

      bp.x = xint
      bp.y = yint
      true
