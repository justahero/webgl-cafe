#= require_self

shaders =
  'main_vertex': """
    varying vec3 vWorldNormal;
    varying vec4 vWorldPosition;

    uniform mat4 camProj, camView;
    uniform mat4 lightView;
    uniform mat3 lightRot;
    uniform mat4 model;

    uniform vec3 ambientColor;

    attribute highp vec3 position, normal;

    void main(void) {
        vWorldNormal = (model * vec4(normal, 1.0)).xyz;
        vWorldPosition = model * vec4(position, 1.0);
        gl_Position = camProj * camView * vWorldPosition;
    }
  """
  'main_fragment': """
    varying highp vec3 vWorldNormal;
    varying highp vec4 vWorldPosition;

    uniform highp mat4 camProj, camView;
    uniform highp mat4 lightView;
    uniform highp mat3 lightRot;
    uniform highp mat4 model;

    uniform highp vec3 ambientColor;

    highp float PI = 3.14159265358979323846264;

    highp float attenuation(highp vec3 dir){
        highp float dist = length(dir);
        highp float radiance = 1.0 / (1.0 + pow(dist / 10.0, 2.0));
        return clamp(radiance * 10.0, 0.0, 1.0);
    }

    highp float influence(highp vec3 normal, highp float coneAngle){
        highp float minConeAngle = ((360.0 - coneAngle - 10.0) / 360.0) * PI;
        highp float maxConeAngle = ((360.0 - coneAngle) / 360.0) * PI;
        return smoothstep(minConeAngle, maxConeAngle, acos(normal.z));
    }

    highp float lambert(highp vec3 surfaceNormal, highp vec3 lightDirNormal) {
        return max(0.0, dot(surfaceNormal, lightDirNormal));
    }

    highp vec3 gamma(highp vec3 color) {
        return pow(color, vec3(2.2));
    }

    void main(void) {
        highp vec3 worldNormal = normalize(vWorldNormal);

        highp vec3 camPos   = (camView * vWorldPosition).xyz;
        highp vec3 lightPos = (lightView * vWorldPosition).xyz;
        highp vec3 lightPosNormal     = normalize(lightPos);
        highp vec3 lightSurfaceNormal = lightRot * worldNormal;

        highp vec3 excident = (
          ambientColor +
          lambert(lightSurfaceNormal, -lightPosNormal) *
          influence(lightPosNormal, 50.0) *
          attenuation(lightPos)
        );

        gl_FragColor = vec4(gamma(excident), 1.0);
    }
  """

canvas  = null
context = null

camera = new Cafe.Camera()

lightView = new Cafe.Matrix4().translate([0, 2.5, -7.5]).rotateX(Math.PI / 4.5).rotateY(Math.PI * 2.25)
lightRot  = Cafe.Matrix3.fromMat4Rot(lightView)

ambientColor = new Cafe.Color(0.25, 0.25, 0.25)

cube_mesh  = null
plane_mesh = null

program = null

duration = 8000.0
currentTime = Date.now()

initMeshes = (context) ->
  cube_mesh = Cafe.Mesh.create(context, Cafe.Primitives.Cube.create(1.3), false)
  cube_mesh.translate([0, 1.0, 0])
  plane_mesh = Cafe.Mesh.create(context, Cafe.Primitives.Plane.create(7.5, 7.5), false)
  plane_mesh.translate([0, -0.99, 0])
  # plane_mesh.translate([0, -1, 0])

initShaders = (context) ->
  compiler = new Cafe.WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

animate = () ->
  now = Date.now()
  deltat = now - currentTime
  currentTime = now

  fract = deltat / duration
  angle = Math.PI * 2.0 * fract
  cube_mesh.rotate(angle, [0, 1, 0])
  plane_mesh.rotate(angle / 2, [0, -1, 0])

render = (context, canvas) ->
  context.clearBuffer(Cafe.Color.BLACK)

  camera.perspective(Math.PI / 3, context.aspect(), 1, 10000)
  program.matrix4("camProj", camera.projection)
  camera.lookat([0, 8, 15], [0, 0, 0], [0, 1, 0])
  program.matrix4("camView", camera.view)

  program.matrix4("lightView", lightView)
  program.matrix3("lightRot", lightRot)

  program.matrix4("model", cube_mesh.modelMatrix)
  program.render(cube_mesh)

  program.matrix4("model", plane_mesh.modelMatrix)
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

  renderLoop(context, canvas)
