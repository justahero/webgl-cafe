namespace 'Cafe', (exports) ->
  class exports.Texture
    constructor: (gl, @filename) ->
      @type    = gl.TEXTURE_2D
      @texture = gl.createTexture()
      @texture.image = new Image()
      @texture.image.onload = => @onTextureLoaded(gl, @texture)
      @texture.image.src = filename

    onTextureLoaded: (gl, texture) ->
      console.log("Texture #{texture.image.src} loaded!")
      gl.bindTexture(gl.TEXTURE_2D, texture)
      gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, texture.image)
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST)
      gl.generateMipmap(gl.TEXTURE_2D)
      gl.bindTexture(gl.TEXTURE_2D, null)
