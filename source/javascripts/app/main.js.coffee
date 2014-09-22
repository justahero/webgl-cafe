#= require_self

shaders =
  'main_vertex': """
                 attribute highp vec3 vertexPos;
                 attribute highp vec2 texCoord;
                 attribute highp vec3 normalPos;

                 uniform highp mat4 modelViewMatrix;
                 uniform highp mat4 projectionMatrix;
                 uniform highp mat4 normalMatrix;

                 uniform vec3 ambientColor;
                 uniform vec3 directionalColor;
                 uniform vec3 directionalVector;

                 varying highp vec2 vTextureCoord;
                 varying highp vec3 vLighting;

                 void main(void) {
                     gl_Position = projectionMatrix * modelViewMatrix * vec4(vertexPos, 1);

                     // apply lighting effect
                     highp vec4 transformedNormal = normalMatrix * vec4(normalPos, 1.0);
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

projectionMatrix = mat4.create()
normalMatrix     = mat4.create()

mesh = new Cafe.Mesh()

indexBuffer     = null
texcoordsBuffer = null
vertexBuffer    = null
normalBuffer    = null

texture = null
ambientColor = new Cafe.Color(0.3, 0.3, 0.3)
direction = vec3.fromValues(0.5, 1, 1)
directionalLight = new Cafe.DirectionalLight(
  new Cafe.Color(0.8, 1.0, 0.8), vec3.normalize(direction, direction)
)

program = null

duration = 5000.0
currentTime = Date.now()


initTextures = (context) ->
  texture = new Cafe.Texture(context.gl, 'resources/images/water512.jpg')

initMatrices = (canvas) ->
  mat4.translate(mesh.modelMatrix, mesh.modelMatrix, [0, 0, -5])
  mat4.perspective(projectionMatrix, Math.PI / 3, canvas.width / canvas.height, 1, 10000)

initMeshes = (context) ->
  cube = Cafe.Primitives.Cube.create(1.2)
  vertexBuffer    = new Cafe.VertexBuffer(context.gl, cube.vertices, 3)
  texcoordsBuffer = new Cafe.VertexBuffer(context.gl, cube.texcoords, 2)
  normalBuffer    = new Cafe.VertexBuffer(context.gl, cube.normals, 3)
  indexBuffer     = new Cafe.IndexBuffer(context.gl, cube.indices)

initShaders = (context) ->
  compiler = new Cafe.WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

animate = () ->
  now = Date.now()
  deltat = now - currentTime
  currentTime = now

  fract = deltat / duration
  angle = Math.PI * 2.0 * fract

  mat4.rotate(mesh.modelMatrix, mesh.modelMatrix, angle, [0, 1, 1])

  mat4.invert(normalMatrix, mesh.modelMatrix)
  mat4.transpose(normalMatrix, normalMatrix)

render = (context, canvas) ->
  context.clearBuffer(Cafe.Color.WHITE)

  context.useProgram(program)

  program.bindVertexBuffer("vertexPos", vertexBuffer)
  program.bindVertexBuffer("texCoord", texcoordsBuffer)
  program.bindVertexBuffer("normalPos", normalBuffer)
  program.bindIndexBuffer(indexBuffer)

  program.uniformMatrix4fv("projectionMatrix", projectionMatrix)
  program.uniformMatrix4fv("modelViewMatrix", mesh.modelMatrix)
  program.uniformMatrix4fv("normalMatrix", normalMatrix)

  program.uniform3f("ambientColor", ambientColor)
  program.uniform3f("directionalColor", directionalLight.color)
  program.uniform3fv("directionalVector", directionalLight.direction)
  program.bindTexture("uSampler", texture)

  context.drawTriangles(indexBuffer.size)


renderLoop = (context, canvas) ->
  requestAnimationFrame(-> renderLoop(context, canvas))
  render(context, canvas)
  animate()

@main = ->
  canvas  = document.getElementById('webglcanvas')
  context = new Cafe.Context(canvas)

  initMatrices(canvas)
  initTextures(context)
  initShaders(context)
  initMeshes(context)

  renderLoop(context, canvas)
