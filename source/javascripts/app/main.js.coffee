#= require_self

shaders =
  'main_vertex': """
                 attribute vec2 vertexCoord;
                 void main(void) {
                     gl_Position = vec4(vertexCoord, 0.0, 1.0);
                 }
                 """
  'main_fragment': """
                   void main(void) {
                       gl_FragColor = vec4(0.0, 0.0, 1.0, 1.0);
                   }
                   """

@main = ->
  canvas  = document.getElementById('webglcanvas')
  context = new GlContext(canvas)

  compiler = new WebGlCompiler(context.gl, shaders)
  program  = compiler.createProgramWithShaders('main_vertex', 'main_fragment')

  context.clearBuffer(GlColor.BLACK)
  context.useProgram(program)
  vertexCoord = program.getAttribLocation("vertexCoord")

  vertices = new Float32Array([
    -0.8, -0.8,
     0.8, -0.8,
    -0.8,  0.8,
    -0.8,  0.8,
     0.8, -0.8,
     0.8,  0.8
  ])

  buffer = new VertexBuffer(context.gl, vertices, 2)
  buffer.render(vertexCoord)
