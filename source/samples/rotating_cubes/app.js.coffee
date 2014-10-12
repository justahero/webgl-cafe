#= require_self

shaders =
  'main_vertex': """
                 attribute highp vec3 position;
                 attribute highp vec2 texCoord;
                 attribute highp vec3 normal;

                 uniform highp mat4 modelViewMatrix;
                 uniform highp mat4 campProj;
                 uniform highp mat4 normalMatrix;

                 uniform vec3 ambientColor;
                 uniform vec3 directionalColor;
                 uniform vec3 directionalVector;

                 varying highp vec2 vTextureCoord;
                 varying highp vec3 vLighting;

                 void main(void) {
                     gl_Position = campProj * modelViewMatrix * vec4(position, 1);

                     // apply lighting effect
                     highp vec4 transformedNormal = normalMatrix * vec4(normal, 1.0);
                     highp float directional = max(dot(transformedNormal.xyz, directionalVector), 0.0);

                     vLighting = ambientColor + (directionalColor * directional);
                     vTextureCoord = texCoord;
                 }
                 """
  'main_fragment': """
                   varying highp vec2 vTextureCoord;
                   varying highp vec3 vLighting;

                   uniform sampler2D uSampler;

                   void main(void) {
                       mediump vec4 texelColor = texture2D(uSampler, vec2(vTextureCoord.s, vTextureCoord.t));

                       gl_FragColor = vec4(texelColor.rgb * vLighting, 1.0);
                   }
                   """
canvas  = null
context = null

campProj     = new Cafe.Matrix4()
normalMatrix = new Cafe.Matrix4()

meshes = []

texture = null
ambientColor = new Cafe.Color(0.1, 0.1, 0.1)
direction = vec3.fromValues(0.5, 1, 1)
directionalLight = new Cafe.DirectionalLight(
  new Cafe.Color(0.8, 1.0, 0.8), vec3.normalize(direction, direction)
)

program = null

duration = 3000.0
currentTime = Date.now()

initTextures = (context) ->
  texture = new Cafe.Texture(context.gl, '/resources/images/water512.jpg')

initMeshes = (context) ->
  numCubes = 10
  xoffset  = (-numCubes + 1) / 2
  zoffset  = -20

  size = 0.25
  cube = Cafe.Primitives.Cube.create(size)

  for x in [0...numCubes]
    for y in [0...numCubes]
      for z in [0...numCubes]
        mesh = Cafe.Mesh.create(context, cube)
        mesh.translate([xoffset + y, xoffset + x, zoffset + z])
        meshes.push mesh

initShaders = (context) ->
  compiler = new Cafe.WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

animate = () ->
  now = Date.now()
  deltat = now - currentTime
  currentTime = now

  fract = deltat / duration
  angle = Math.PI * 2.0 * fract

  for mesh in meshes
    mesh.rotate(angle, [0, 1, 1])

render = (context, canvas) ->
  context.clearBuffer(Cafe.Color.WHITE)
  campProj.perspective(Math.PI / 3.5, canvas.width / canvas.height, 1, 10000)

  program.matrix4("campProj", campProj)
  program.bindTexture("uSampler", texture)

  for mesh in meshes
    normalMatrix.set(mesh.modelMatrix).invert().transpose()
    program.matrix4("modelViewMatrix", mesh.modelMatrix)
    program.matrix4("normalMatrix", normalMatrix)
    program.render(mesh)

renderLoop = (context, canvas) ->
  requestAnimationFrame(-> renderLoop(context, canvas))
  render(context, canvas)
  animate()

@main = ->
  canvas  = document.getElementById('webglcanvas')
  context = new Cafe.Context(canvas)

  initTextures(context)
  initShaders(context)
  initMeshes(context)

  context.useProgram(program)

  program.uniform3f("ambientColor", ambientColor)
  program.uniform3f("directionalColor", directionalLight.color)
  program.uniform3fv("directionalVector", directionalLight.direction)

  renderLoop(context, canvas)
