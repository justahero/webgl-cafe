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

resizeCanvas = () ->
  canvas.width  = window.innerWidth
  canvas.height = window.innerHeight
  context.setViewport(0, 0, canvas.width, canvas.height)
  mat4.perspective(projectionMatrix, Math.PI / 3, canvas.width / canvas.height, 1, 10000)

initTextures = (context) ->
  texture = new Cafe.Texture(context.gl, '/resources/images/water512.jpg')

initMeshes = (context) ->
  numCubes = 16
  xoffset  = (-numCubes + 1) / 2
  zoffset  = -24

  size = 0.25
  cube = Cafe.Primitives.Cube.create(size)

  for x in [0...numCubes]
    for y in [0...numCubes]
      for z in [0...numCubes]
        mesh = new Cafe.Mesh()
        mesh.addVertexBuffer("vertexPos", new Cafe.VertexBuffer(context.gl, cube.vertices, 3))
        mesh.addVertexBuffer("texCoord", new Cafe.VertexBuffer(context.gl, cube.texcoords, 2))
        mesh.addVertexBuffer("normalPos", new Cafe.VertexBuffer(context.gl, cube.normals, 3))
        mesh.setIndexBuffer(new Cafe.IndexBuffer(context.gl, cube.indices))
        mat4.translate(mesh.modelMatrix, mesh.modelMatrix, [xoffset + y, xoffset + x, zoffset + z])
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
    mat4.rotate(mesh.modelMatrix, mesh.modelMatrix, angle, [0, 1, 1])

render = (context, canvas) ->
  context.clearBuffer(Cafe.Color.WHITE)

  program.uniformMatrix4fv("projectionMatrix", projectionMatrix)
  program.bindTexture("uSampler", texture)

  for mesh in meshes
    program.bindMesh(mesh)

    mat4.invert(normalMatrix, mesh.modelMatrix)
    mat4.transpose(normalMatrix, normalMatrix)

    program.uniformMatrix4fv("modelViewMatrix", mesh.modelMatrix)
    program.uniformMatrix4fv("normalMatrix", normalMatrix)

    context.drawTriangles(mesh.indexBuffer.size)

renderLoop = (context, canvas) ->
  requestAnimationFrame(-> renderLoop(context, canvas))
  render(context, canvas)
  animate()

@main = ->
  window.onresize = resizeCanvas

  canvas  = document.getElementById('webglcanvas')
  context = new Cafe.Context(canvas)

  initTextures(context)
  initShaders(context)
  initMeshes(context)

  context.useProgram(program)

  program.uniform3f("ambientColor", ambientColor)
  program.uniform3f("directionalColor", directionalLight.color)
  program.uniform3fv("directionalVector", directionalLight.direction)

  resizeCanvas()

  renderLoop(context, canvas)
