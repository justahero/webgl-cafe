#= require_self

shaders =
  'main_vertex': """
                 attribute highp vec3 vertexPos;
                 attribute highp vec3 normalPos;

                 uniform highp mat4 modelViewMatrix;
                 uniform highp mat4 projectionMatrix;
                 uniform highp mat4 normalMatrix;

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
                 }
                 """
  'main_fragment': """
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

indexBuffer  = null
vertexBuffer = null
normalBuffer = null

program = null

duration = 5000.0
currentTime = Date.now()

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
  context.clearBuffer(GlColor.WHITE)

  context.useProgram(program)

  program.bindVertexBuffer("vertexPos", vertexBuffer)
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
  context = new GlContext(canvas)

  context.setViewport(0, 0, canvas.width, canvas.height)
  initMatrices(canvas)

  compiler = new WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

  vertices = new Float32Array([
    -1.0, -1.0,  1.0,
     1.0, -1.0,  1.0,
     1.0,  1.0,  1.0,
    -1.0,  1.0,  1.0,

    -1.0, -1.0, -1.0,
    -1.0,  1.0, -1.0,
     1.0,  1.0, -1.0,
     1.0, -1.0, -1.0,

    -1.0,  1.0, -1.0,
    -1.0,  1.0,  1.0,
     1.0,  1.0,  1.0,
     1.0,  1.0, -1.0,

    -1.0, -1.0, -1.0,
     1.0, -1.0, -1.0,
     1.0, -1.0,  1.0,
    -1.0, -1.0,  1.0,

     1.0, -1.0, -1.0,
     1.0,  1.0, -1.0,
     1.0,  1.0,  1.0,
     1.0, -1.0,  1.0,

    -1.0, -1.0, -1.0,
    -1.0, -1.0,  1.0,
    -1.0,  1.0,  1.0,
    -1.0,  1.0, -1.0,
  ])
  vertexBuffer = new VertexBuffer(context.gl, vertices, 3)

  normals = new Float32Array([
     0.0,  0.0,  1.0,
     0.0,  0.0,  1.0,
     0.0,  0.0,  1.0,
     0.0,  0.0,  1.0,

     0.0,  0.0, -1.0,
     0.0,  0.0, -1.0,
     0.0,  0.0, -1.0,
     0.0,  0.0, -1.0,

     0.0,  1.0,  0.0,
     0.0,  1.0,  0.0,
     0.0,  1.0,  0.0,
     0.0,  1.0,  0.0,

     0.0, -1.0,  0.0,
     0.0, -1.0,  0.0,
     0.0, -1.0,  0.0,
     0.0, -1.0,  0.0,

     1.0,  0.0,  0.0,
     1.0,  0.0,  0.0,
     1.0,  0.0,  0.0,
     1.0,  0.0,  0.0,

    -1.0,  0.0,  0.0,
    -1.0,  0.0,  0.0,
    -1.0,  0.0,  0.0,
    -1.0,  0.0,  0.0,
  ])
  normalBuffer = new VertexBuffer(context.gl, normals, 3)

  indices = new Uint16Array([
     0,  1,  2,    0,  2,  3,   # Front face
     4,  5,  6,    4,  6,  7,   # Back face
     8,  9, 10,    8, 10, 11,   # Top face
    12, 13, 14,   12, 14, 15,   # Bottom face
    16, 17, 18,   16, 18, 19,   # Right face
    20, 21, 22,   20, 22, 23    # Left face
  ])
  indexBuffer = new IndexBuffer(context.gl, indices)

  renderLoop(context, canvas)
