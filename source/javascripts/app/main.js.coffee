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

  context.clearBuffer(GlColor.WHITE)

  gl = context.gl
  gl.useProgram(program)
  coordinates = new Float32Array([
     0.0,  0.8
    -0.8, -0.8
     0.8, -0.8
  ])
  vertexCoord = gl.getAttribLocation(program, "vertexCoord")
 
  buffer = gl.createBuffer()
  gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
  gl.bufferData(gl.ARRAY_BUFFER, coordinates, gl.STATIC_DRAW)
 
  gl.enableVertexAttribArray(vertexCoord)
  gl.vertexAttribPointer(vertexCoord, 2, gl.FLOAT, false, 0, 0)
 
  gl.drawArrays(gl.TRIANGLES, 0, 3)