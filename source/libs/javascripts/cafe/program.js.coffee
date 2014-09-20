namespace 'Cafe', (exports) ->
  class exports.Program
    constructor: (@gl, @vertexShader, @fragmentShader) ->
      @program = null

      @_attributes = null
      @_uniforms   = null
      @_link(@gl)

    uniformMatrix4fv: (uniformName, matrix) ->
      uniform = @uniformLocation(uniformName)
      @gl.uniformMatrix4fv(uniform, false, matrix);

    bindVertexBuffer: (attribName, vertexBuffer) ->
      attribute = @getAttribLocation(attribName)
      @gl.enableVertexAttribArray(attribute)
      @gl.bindBuffer(@gl.ARRAY_BUFFER, vertexBuffer.buffer)
      @gl.vertexAttribPointer(attribute, vertexBuffer.itemSize, @gl.FLOAT, false, 0, 0)

    bindIndexBuffer: (indexBuffer) ->
      @gl.bindBuffer(@gl.ELEMENT_ARRAY_BUFFER, indexBuffer.buffer)

    getAttribLocation: (attribName) ->
      location = @gl.getAttribLocation(@program, attribName)
      if location == -1
         throw "Could not getAttribLocation for #{attribName}"
      location

    uniformLocation: (attribName) ->
      location = @gl.getUniformLocation(@program, attribName)
      if location == -1
         throw "Could not getUniformLocation for #{attribName}"
      location

    _link: (gl) ->
      @program = gl.createProgram()
      gl.attachShader(@program, @vertexShader.shader)
      gl.attachShader(@program, @fragmentShader.shader)
      gl.linkProgram(@program)

      unless gl.getProgramParameter(@program, gl.LINK_STATUS)
        error = gl.getProgramInfoLog(@program)
        throw "Could not compile program, error: #{error}"

      @_attributes = @findActiveAttributes(gl)
      @_uniforms   = @findActiveUniforms(gl)

      @program

    findActiveAttributes: (gl) ->
      numActiveAttributes = @_getNumActiveAttributes(gl)
      for i in [0...numActiveAttributes]
        gl.getActiveAttrib(@program, i)

    findActiveUniforms: (gl) ->
      numActiveUniforms = @_getNumActiveUniforms(gl)
      for i in [0...numActiveUniforms]
        gl.getActiveUniform(@program, i)

    _getNumActiveAttributes: (gl) ->
      gl.getProgramParameter(@program, gl.ACTIVE_ATTRIBUTES)

    _getNumActiveUniforms: (gl) ->
      gl.getProgramParameter(@program, gl.ACTIVE_UNIFORMS)
