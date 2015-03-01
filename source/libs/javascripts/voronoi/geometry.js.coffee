namespace 'Voronoi', (exports) ->
  class exports.Geometry
    @bisect: (s1, s2) ->
      newedge = new Edge(s1, s2)
      d = Point.subtract(s1, s2)
      adx = Math.abs(d.x)
      ady = Math.abs(d.y)
      newedge.c = Point.dot(s1, d) + d.dot() * 0.5

      if adx > ady
        newedge.a = 1.0
        newedge.b = d.y / d.x
        newedge.c /= d.x
      else
        newedge.b = 1.0
        newedge.a = d.x / d.y
        newedge.c /= d.y

      newedge
