#= require_self

shaders =
  'main_vertex': """
    attribute highp vec3 position;
    attribute highp vec3 normal;

    uniform mat4 camProj;
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

        gl_Position = camProj * vWorldPosition;

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

camProj = new Cafe.Matrix4()
normalMatrix = new Cafe.Matrix4()

cube_mesh  = null
plane_mesh = null

ambientColor = new Cafe.Color(0.1, 0.1, 0.1)
direction = vec3.fromValues(0.5, 1, 1)
directionalLight = new Cafe.DirectionalLight(
  new Cafe.Color(0.5, 0.5, 0.5), vec3.normalize(direction, direction)
)

program = null

duration = 3000.0
currentTime = Date.now()

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
  context.clearBuffer(Cafe.Color.BLACK)

  camProj.perspective(Math.PI / 3.5, context.aspect(), 1, 10000)
  program.matrix4("camProj", camProj)

  normalMatrix.set(cube_mesh.modelMatrix).invert().transpose()
  program.matrix4("model", cube_mesh.modelMatrix)
  program.matrix4("normalMatrix", normalMatrix)
  program.render(cube_mesh)

  normalMatrix.set(plane_mesh.modelMatrix).invert().transpose()
  program.matrix4("model", plane_mesh.modelMatrix)
  program.matrix4("normalMatrix", normalMatrix)
  program.render(plane_mesh)

renderLoop = (context, canvas) ->
  requestAnimationFrame(-> renderLoop(context, canvas))
  render(context, canvas)
  animate()

@main = ->
  canvas  = document.getElementById('webglcanvas')
  context = new Cafe.Context(canvas)

  initShaders(context)
  initMeshes(context)

  context.useProgram(program)

  program.uniform3f("ambientColor", ambientColor)
  program.uniform3f("directionalColor", directionalLight.color)
  program.uniform3fv("directionalVector", directionalLight.direction)

  renderLoop(context, canvas)
