#= require_self

shaders =
  'main_vertex': """
                 uniform highp mat4 u_matrix;
                 attribute highp vec3 position;
                 uniform highp vec3 color;
                 varying highp vec3 v_color;

                 void main(void) {
                   gl_PointSize = 3.0;
                   gl_Position  = u_matrix * vec4(position, 1.0);
                   v_color      = color;
                 }
  """
  'main_fragment': """
                   varying highp vec3 v_color;

                   void main(void) {
                     gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
                   }
  """

ambient = new Cafe.Color(1.0, 1.0, 1.0)
canvas  = null
context = null
program = null
matrix  = new Cafe.Matrix4()

points  = null
voronoi = null
vertices = []

initShaders = (context) ->
  compiler = new Cafe.WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

initVoronoi = (canvas, context) ->
  voronoi  = new Voronoi.Main()
  for num in [1..100]
    x = Cafe.MathHelpers.random(0, canvas.width)
    y = Cafe.MathHelpers.random(0, canvas.height)
    vertices.push {x: x, y: y}
  points = Cafe.Mesh.create2dPoints(context, vertices)

render = (context, canvas) ->
  context.clearBuffer(Cafe.Color.BLACK)

  matrix.orthogonal(0, canvas.width, 0, canvas.height)
  program.matrix4("u_matrix", matrix)

  program.render2dPoints(points)

  edges = voronoi.calculate(vertices)
  lines = Cafe.Mesh.create2dLines(context, edges)
  program.render2dLines(lines)

renderLoop = (context, canvas) ->
  requestAnimationFrame(-> renderLoop(context, canvas))
  render(context, canvas)

@main = ->
  canvas  = document.getElementById('webglcanvas')
  context = new Cafe.Context(canvas)

  initShaders(context)
  initVoronoi(canvas, context)

  context.useProgram(program)

  program.uniform3f("color", ambient)

  renderLoop(context, canvas)
