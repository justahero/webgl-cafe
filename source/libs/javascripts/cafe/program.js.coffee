namespace 'Cafe', (exports) ->
  class exports.Program
    constructor: (@gl, @vertexShader, @fragmentShader) ->
      @program = null

      @_attributesMap = null
      @_uniformsMap   = null
      @_link(@gl)

    uniformMatrix4fv: (uniformName, matrix) ->
      uniform = @uniformLocation(uniformName)
      @gl.uniformMatrix4fv(uniform, false, matrix);

    uniform3f: (uniformName, color) ->
      uniform = @uniformLocation(uniformName)
      @gl.uniform3f(uniform, color.red, color.green, color.blue)

    uniform3fv: (uniformName, vector) ->
      uniform = @uniformLocation(uniformName)
      @gl.uniform3fv(uniform, vector)

    bindVertexBuffer: (attribName, vertexBuffer) ->
      attribute = @getAttribLocation(attribName)
      @gl.enableVertexAttribArray(attribute)
      @gl.bindBuffer(@gl.ARRAY_BUFFER, vertexBuffer.buffer)
      @gl.vertexAttribPointer(attribute, vertexBuffer.itemSize, @gl.FLOAT, false, 0, 0)

    bindIndexBuffer: (indexBuffer) ->
      @gl.bindBuffer(@gl.ELEMENT_ARRAY_BUFFER, indexBuffer.buffer)

    bindTexture: (uniformName, texture) ->
      uniform = @uniformLocation(uniformName)
      @gl.activeTexture(@gl.TEXTURE0)
      @gl.bindTexture(texture.type, texture.texture)
      @gl.uniform1i(uniform, 0)

    bindMesh: (mesh) ->
      for {name, buffer} in mesh.vertexBuffers
        @bindVertexBuffer(name, buffer)
      if mesh.indexBuffer
        @bindIndexBuffer(mesh.indexBuffer)

    getAttribLocation: (attribName) ->
      location = @_attributesMap[attribName]
      if location == -1
         throw "Could not getAttribLocation for #{attribName}"
      location

    uniformLocation: (attribName) ->
      location = @_uniformsMap[attribName]
      unless location
         throw "Could not getUniformLocation for #{attribName}"
      location

    numAttributes: () ->
      @_attributesMap.length

    numUniforms: () ->
      @_uniformsMap.length

    _link: (gl) ->
      @program = gl.createProgram()
      gl.attachShader(@program, @vertexShader.shader)
      gl.attachShader(@program, @fragmentShader.shader)
      gl.linkProgram(@program)

      unless gl.getProgramParameter(@program, gl.LINK_STATUS)
        error = gl.getProgramInfoLog(@program)
        throw "Could not compile program, error: #{error}"

      @_attributesMap = @_findActiveAttribsMap(gl)
      @_uniformsMap   = @_findActiveUniformsMap(gl)

      @program

    _findActiveAttribsMap: (gl) ->
      result = {}
      numActiveAttributes = @_getNumActiveAttributes(gl)
      for i in [0...numActiveAttributes]
        info = gl.getActiveAttrib(@program, i)
        result[info.name] = gl.getAttribLocation(@program, info.name)
      result

    _findActiveUniformsMap: (gl) ->
      result = {}
      numActiveUniforms = @_getNumActiveUniforms(gl)
      for i in [0...numActiveUniforms]
        info = gl.getActiveUniform(@program, i)
        result[info.name] = gl.getUniformLocation(@program, info.name)
      result

    _getNumActiveAttributes: (gl) ->
      gl.getProgramParameter(@program, gl.ACTIVE_ATTRIBUTES)

    _getNumActiveUniforms: (gl) ->
      gl.getProgramParameter(@program, gl.ACTIVE_UNIFORMS)
