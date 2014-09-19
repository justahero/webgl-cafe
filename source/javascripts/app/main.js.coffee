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

modelViewMatrix  = null
projectionMatrix = null

indexBuffer  = null
vertexBuffer = null
normalBuffer = null

program = null
shaderVertexPositionAttribute = null
shaderNormalPositionAttribute = null
shaderProjectionMatrixUniform = null
shaderModelViewMatrixUniform  = null

duration = 5000.0
currentTime = Date.now()

initMatrices = (canvas) ->
  modelViewMatrix = mat4.create()
  mat4.translate(modelViewMatrix, modelViewMatrix, [0, 0, -5])

  projectionMatrix = mat4.create()
  mat4.perspective(projectionMatrix, Math.PI / 3, canvas.width / canvas.height, 1, 10000)

initViewport = (context, canvas) ->
  context.setViewport(0, 0, canvas.width, canvas.height)

animate = () ->
  now = Date.now()
  deltat = now - currentTime
  currentTime = now

  fract = deltat / duration
  angle = Math.PI * 2.0 * fract

  mat4.rotate(modelViewMatrix, modelViewMatrix, angle, [0, 1, 1])

render = (context, canvas) ->
  context.clearBuffer(GlColor.BLACK)

  context.useProgram(program)

  context.gl.enableVertexAttribArray(shaderVertexPositionAttribute)
  context.gl.bindBuffer(context.gl.ARRAY_BUFFER, vertexBuffer.buffer)
  context.gl.vertexAttribPointer(shaderVertexPositionAttribute, 3, context.gl.FLOAT, false, 0, 0)
  context.gl.bindBuffer(context.gl.ARRAY_BUFFER, normalBuffer.buffer)
  context.gl.vertexAttribPointer(shaderNormalPositionAttribute, 3, context.gl.FLOAT, false, 0, 0)
  context.gl.bindBuffer(context.gl.ELEMENT_ARRAY_BUFFER, indexBuffer.buffer)

  context.gl.uniformMatrix4fv(shaderProjectionMatrixUniform, false, projectionMatrix);
  context.gl.uniformMatrix4fv(shaderModelViewMatrixUniform, false, modelViewMatrix);

  context.gl.drawElements(context.gl.TRIANGLES, indexBuffer.size, context.gl.UNSIGNED_SHORT, 0);


renderLoop = (context, canvas) ->
  requestAnimationFrame(-> renderLoop(context, canvas))
  render(context, canvas)
  animate()

@main = ->
  canvas  = document.getElementById('webglcanvas')
  context = new GlContext(canvas)

  initViewport(context, canvas)
  initMatrices(canvas)

  compiler = new WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

  gl = context.gl

  shaderVertexPositionAttribute = program.getAttribLocation("vertexPos")
  gl.enableVertexAttribArray(shaderVertexPositionAttribute)
  shaderNormalPositionAttribute = program.getAttribLocation("normalPos")
  gl.enableVertexAttribArray(shaderNormalPositionAttribute)
  shaderProjectionMatrixUniform = program.uniformLocation("projectionMatrix")
  shaderModelViewMatrixUniform  = program.uniformLocation("modelViewMatrix")

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
