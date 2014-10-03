#= require_self

shaders =
  'main_vertex': """
    attribute highp vec3 position;
    attribute highp vec3 normal;

    uniform mat4 projectionMatrix;
    uniform mat4 normalMatrix;
    uniform mat4 model;

    uniform vec3 ambientColor;
    uniform vec3 directionalColor;
    uniform vec3 directionalVector;

    varying highp vec3 vLighting;

    varying vec3 vWorldNormal;
    varying vec4 vWorldPosition;

    void main(void) {
        vWorldNormal = normal;
        vWorldPosition = model * vec4(position, 1.0);

        gl_Position = projectionMatrix * vWorldPosition;

        // apply lighting effect
        highp vec4 transformedNormal = normalMatrix * vec4(normal, 1.0);
        highp float directional = max(dot(transformedNormal.xyz, directionalVector), 0.0);

        vLighting = ambientColor + (directionalColor * directional);
    }
  """
  'main_fragment': """
    varying highp vec3 vLighting;

    uniform sampler2D uSampler;

    void main(void) {
        gl_FragColor = vec4(vLighting, 1.0);
    }
  """

canvas  = null
context = null

projectionMatrix = mat4.create()
normalMatrix     = mat4.create()

cube_mesh  = null
plane_mesh = null

texture = null
ambientColor = new Cafe.Color(0.1, 0.1, 0.1)
direction = vec3.fromValues(0.5, 1, 1)
directionalLight = new Cafe.DirectionalLight(
  new Cafe.Color(0.8, 0.8, 0.8), vec3.normalize(direction, direction)
)

program = null

duration = 3000.0
currentTime = Date.now()

resizeCanvas = () ->
  canvas.width  = window.innerWidth
  canvas.height = window.innerHeight
  context.setViewport(0, 0, canvas.width, canvas.height)
  mat4.perspective(projectionMatrix, Math.PI / 3.5, canvas.width / canvas.height, 1, 10000)

initTextures = (context) ->
  texture = new Cafe.Texture(context.gl, '/resources/images/water512.jpg')

initMeshes = (context) ->
  cube_mesh = Cafe.Mesh.create(context, Cafe.Primitives.Cube.create(0.25), false)
  cube_mesh.trans([0, 0, -5])
  plane_mesh = Cafe.Mesh.create(context, Cafe.Primitives.Plane.create(2, 2), false)
  plane_mesh.trans([0, -1, -5])

initShaders = (context) ->
  compiler = new Cafe.WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

animate = () ->
  now = Date.now()
  deltat = now - currentTime
  currentTime = now

  fract = deltat / duration
  angle = Math.PI * 2.0 * fract

  cube_mesh.rotate(angle, [0, 1, 1])

render = (context, canvas) ->
  context.clearBuffer(Cafe.Color.WHITE)

  program.matrix4("projectionMatrix", projectionMatrix)

  mat4.invert(normalMatrix, cube_mesh.modelMatrix)
  mat4.transpose(normalMatrix, normalMatrix)
  program.matrix4("model", cube_mesh.modelMatrix)
  program.matrix4("normalMatrix", normalMatrix)
  program.render(cube_mesh)

  mat4.invert(normalMatrix, plane_mesh.modelMatrix)
  mat4.transpose(normalMatrix, normalMatrix)
  program.matrix4("model", plane_mesh.modelMatrix)
  program.matrix4("normalMatrix", normalMatrix)
  program.render(plane_mesh)

renderLoop = (context, canvas) ->
  requestAnimationFrame(-> renderLoop(context, canvas))
  render(context, canvas)
  animate()

@main = ->
  window.onresize = resizeCanvas

  canvas  = document.getElementById('webglcanvas')
  context = new Cafe.Context(canvas)

  initTextures(context)
  initShaders(context)
  initMeshes(context)

  context.useProgram(program)

  program.uniform3f("ambientColor", ambientColor)
  program.uniform3f("directionalColor", directionalLight.color)
  program.uniform3fv("directionalVector", directionalLight.direction)

  resizeCanvas()

  renderLoop(context, canvas)
