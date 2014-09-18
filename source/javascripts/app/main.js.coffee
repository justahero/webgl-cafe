#= require_self

shaders =
  'main_vertex': """
                 attribute vec3 vertexPos;

                 uniform mat4 modelViewMatrix;
                 uniform mat4 projectionMatrix;

                 void main(void) {
                     gl_Position = projectionMatrix * modelViewMatrix * vec4(vertexPos, 1);
                 }
                 """
  'main_fragment': """
                   void main(void) {
                       gl_FragColor = vec4(0.0, 0.0, 1.0, 1.0);
                   }
                   """

canvas  = null
context = null

modelViewMatrix  = null
projectionMatrix = null

indicesBuffer = null
vertexBuffer  = null

program = null
shaderVertexPositionAttribute = null
shaderProjectionMatrixUniform = null
shaderModelViewMatrixUniform  = null

duration = 5000.0
currentTime = Date.now()

initMatrices = (canvas) ->
  modelViewMatrix = mat4.create()
  mat4.translate(modelViewMatrix, modelViewMatrix, [0, 0, -3.3333])

  projectionMatrix = mat4.create()
  mat4.perspective(projectionMatrix, Math.PI / 4, canvas.width / canvas.height, 1, 10000);

initViewport = (context, canvas) ->
  context.setViewport(0, 0, canvas.width, canvas.height)

animate = () ->
  now = Date.now()
  deltat = now - currentTime
  console.log("DELTA: #{deltat}")
  currentTime = now

  fract = deltat / duration
  angle = Math.PI * 2.0 * fract

  mat4.rotate(modelViewMatrix, modelViewMatrix, angle, [0, 1, 1])

render = (context, canvas) ->
  context.clearBuffer(GlColor.BLACK)
  context.gl.drawArrays(context.gl.TRIANGLES, 0, 12);

  context.useProgram(program)
  context.gl.vertexAttribPointer(shaderVertexPositionAttribute, 2, context.gl.FLOAT, false, 0, 0)
  context.gl.uniformMatrix4fv(shaderProjectionMatrixUniform, false, projectionMatrix);
  context.gl.uniformMatrix4fv(shaderModelViewMatrixUniform, false, modelViewMatrix);


renderLoop = (context, canvas) ->
  requestAnimationFrame(-> renderLoop(context, canvas))
  render(context, canvas)
  animate()

@main = ->
  canvas  = document.getElementById('webglcanvas')
  context = new GlContext(canvas)

  initMatrices(canvas)

  compiler = new WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

  gl = context.gl

  shaderVertexPositionAttribute = program.getAttribLocation("vertexPos")
  gl.enableVertexAttribArray(shaderVertexPositionAttribute)
  shaderProjectionMatrixUniform = program.uniformLocation("projectionMatrix")
  shaderModelViewMatrixUniform  = program.uniformLocation("modelViewMatrix")

  vertices = new Float32Array([
    -1.0, -1.0,  1.0,
     1.0, -1.0,  1.0,
     1.0,  1.0,  1.0,
    -1.0,  1.0,  1.0,
    -1.0, -1.0, -1.0,
     1.0, -1.0, -1.0,
     1.0,  1.0, -1.0,
    -1.0,  1.0, -1.0,
  ])
  vertexBuffer = new VertexBuffer(context.gl, vertices, 24)

  indices = new Uint16Array([
    0, 1, 2,
    2, 3, 0,
    1, 5, 6,
    6, 2, 1,
    7, 6, 5,
    5, 4, 7,
    4, 0, 3,
    3, 7, 4,
    4, 5, 1,
    1, 0, 4,
    3, 2, 6,
    6, 7, 3,
  ])
  indicesBuffer = new IndexBuffer(context.gl, indices)

  renderLoop(context, canvas)
