#= require_self

shaders =
  'main_vertex': """
                 attribute highp vec3 vertexPos;
                 attribute highp vec2 texCoord;
                 attribute highp vec3 normalPos;

                 uniform highp mat4 modelViewMatrix;
                 uniform highp mat4 projectionMatrix;
                 uniform highp mat4 normalMatrix;

                 varying highp vec2 vTextureCoord;
                 varying highp vec3 vLighting;

                 void main(void) {
                     gl_Position = projectionMatrix * modelViewMatrix * vec4(vertexPos, 1);
                     // apply lighting effect
                     highp vec3 ambientLight = vec3(0.5, 0.5, 0.5);
                     highp vec3 directionalLightColor = vec3(0.5, 0.5, 0.75);
                     highp vec3 directionalVector = vec3(0.85, 0.80, 0.75);

                     highp vec4 transformedNormal = normalMatrix * vec4(normalPos, 1.0);

                     highp float directional = max(dot(transformedNormal.xyz, directionalVector), 0.0);

                     vLighting = ambientLight + (directionalLightColor * directional);
                     vTextureCoord = texCoord;
                 }
                 """
  'main_fragment': """
                   varying highp vec2 vTextureCoord;
                   varying highp vec3 vLighting;

                   void main(void) {
                       highp vec3 color = vec3(0.0, 0.0, 1.0);
                       gl_FragColor = vec4(color * vLighting, 1.0);
                   }
                   """

canvas  = null
context = null

modelViewMatrix  = mat4.create()
projectionMatrix = mat4.create()
normalMatrix     = mat4.create()

indexBuffer     = null
texcoordsBuffer = null
vertexBuffer    = null
normalBuffer    = null

program = null

duration = 5000.0
currentTime = Date.now()

myCube = Cafe.Primitives.Cube.create(1.2)

initMatrices = (canvas) ->
  mat4.translate(modelViewMatrix, modelViewMatrix, [0, 0, -5])
  mat4.perspective(projectionMatrix, Math.PI / 3, canvas.width / canvas.height, 1, 10000)

animate = () ->
  now = Date.now()
  deltat = now - currentTime
  currentTime = now

  fract = deltat / duration
  angle = Math.PI * 2.0 * fract

  mat4.rotate(modelViewMatrix, modelViewMatrix, angle, [0, 1, 1])

render = (context, canvas) ->
  context.clearBuffer(Cafe.Color.WHITE)

  context.useProgram(program)

  program.bindVertexBuffer("vertexPos", vertexBuffer)
  program.bindVertexBuffer("texCoord", texcoordsBuffer)
  program.bindVertexBuffer("normalPos", normalBuffer)
  program.bindIndexBuffer(indexBuffer)

  program.uniformMatrix4fv("projectionMatrix", projectionMatrix)
  program.uniformMatrix4fv("modelViewMatrix", modelViewMatrix)
  mat4.invert(normalMatrix, modelViewMatrix)
  mat4.transpose(normalMatrix, normalMatrix)
  program.uniformMatrix4fv("normalMatrix", normalMatrix)

  context.drawTriangles(indexBuffer.size)


renderLoop = (context, canvas) ->
  requestAnimationFrame(-> renderLoop(context, canvas))
  render(context, canvas)
  animate()

@main = ->
  canvas  = document.getElementById('webglcanvas')
  context = new Cafe.Context(canvas)

  context.setViewport(0, 0, canvas.width, canvas.height)
  initMatrices(canvas)

  compiler = new Cafe.WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

  vertexBuffer    = new Cafe.VertexBuffer(context.gl, myCube.vertices, 3)
  texcoordsBuffer = new Cafe.VertexBuffer(context.gl, myCube.texcoords, 2)
  normalBuffer    = new Cafe.VertexBuffer(context.gl, myCube.normals, 3)
  indexBuffer     = new Cafe.IndexBuffer(context.gl, myCube.indices)

  renderLoop(context, canvas)
