#= require_self

shaders =
  'main_vertex': """
                 void main() {
                   gl_FragColor = vec4(0.0, 0.0, 1.0, 1.0);
                 }
                 """
  'main_fragment': """
                   attribute vec2 vertexCoord;
                   void main() {
                     gl_Position = vec4(vertexCoord, 0.0, 1.0);
                   }
                   """

@main = ->
  canvas  = document.getElementById('webglcanvas')
  context = new GlContext(canvas)

  compiler = new WebGlCompiler(context.gl, shaders)

  debugger
