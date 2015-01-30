(function(){var n,e,o,i,a,t,r,l,m,h,g,c,f,v,u,p,d;d={main_vertex:"varying vec3 vWorldNormal;\nvarying vec4 vWorldPosition;\n\nuniform mat4 camProj, camView;\nuniform mat4 lightView;\nuniform mat3 lightRot;\nuniform mat4 model;\n\nuniform vec3 ambientColor;\n\nattribute highp vec3 position, normal;\n\nvoid main(void) {\n    vWorldNormal = (model * vec4(normal, 1.0)).xyz;\n    vWorldPosition = model * vec4(position, 1.0);\n    gl_Position = camProj * camView * vWorldPosition;\n}",main_fragment:"varying highp vec3 vWorldNormal;\nvarying highp vec4 vWorldPosition;\n\nuniform highp mat4 camProj, camView;\nuniform highp mat4 lightView;\nuniform highp mat3 lightRot;\nuniform highp mat4 model;\n\nuniform highp vec3 ambientColor;\n\nhighp float PI = 3.14159265358979323846264;\n\nhighp float attenuation(highp vec3 dir){\n    highp float dist = length(dir);\n    highp float radiance = 1.0 / (1.0 + pow(dist / 10.0, 2.0));\n    return clamp(radiance * 10.0, 0.0, 1.0);\n}\n\nhighp float influence(highp vec3 normal, highp float coneAngle){\n    highp float minConeAngle = ((360.0 - coneAngle - 10.0) / 360.0) * PI;\n    highp float maxConeAngle = ((360.0 - coneAngle) / 360.0) * PI;\n    return smoothstep(minConeAngle, maxConeAngle, acos(normal.z));\n}\n\nhighp float lambert(highp vec3 surfaceNormal, highp vec3 lightDirNormal) {\n    return max(0.0, dot(surfaceNormal, lightDirNormal));\n}\n\nhighp vec3 gamma(highp vec3 color) {\n    return pow(color, vec3(2.2));\n}\n\nvoid main(void) {\n    highp vec3 worldNormal = normalize(vWorldNormal);\n\n    highp vec3 camPos   = (camView * vWorldPosition).xyz;\n    highp vec3 lightPos = (lightView * vWorldPosition).xyz;\n    highp vec3 lightPosNormal     = normalize(lightPos);\n    highp vec3 lightSurfaceNormal = lightRot * worldNormal;\n\n    highp vec3 excident = (\n      ambientColor +\n      lambert(lightSurfaceNormal, -lightPosNormal) *\n      influence(lightPosNormal, 50.0) *\n      attenuation(lightPos)\n    );\n\n    gl_FragColor = vec4(gamma(excident), 1.0);\n}"},i=null,a=null,o=new Cafe.Camera,c=(new Cafe.Matrix4).translate([0,2.5,-7.5]).rotateX(Math.PI/4.5).rotateY(2.25*Math.PI),g=Cafe.Matrix3.fromMat4Rot(c),n=new Cafe.Color(.25,.25,.25),t=null,f=null,v=null,l=8e3,r=Date.now(),m=function(n){return t=Cafe.Mesh.create(n,Cafe.Primitives.Cube.create(1.3),!1),t.translate([0,1,0]),f=Cafe.Mesh.create(n,Cafe.Primitives.Plane.create(7.5,7.5),!1),f.translate([0,-.99,0])},h=function(n){var e;return e=new Cafe.WebGlCompiler(n.gl,d),v=e.createProgramWithShaders("main_vertex","main_fragment")},e=function(){var n,e,o,i;return i=Date.now(),e=i-r,r=i,o=e/l,n=2*Math.PI*o,t.rotate(n,[0,1,0]),f.rotate(n/2,[0,-1,0])},u=function(n){return n.clearBuffer(Cafe.Color.BLACK),o.perspective(Math.PI/3,n.aspect(),1,1e4),v.matrix4("camProj",o.projection),o.lookat([0,8,15],[0,0,0],[0,1,0]),v.matrix4("camView",o.view),v.matrix4("lightView",c),v.matrix3("lightRot",g),v.matrix4("model",t.modelMatrix),v.render(t),v.matrix4("model",f.modelMatrix),v.render(f)},p=function(n,o){return requestAnimationFrame(function(){return p(n,o)}),u(n,o),e()},this.main=function(){return i=document.getElementById("webglcanvas"),a=new Cafe.Context(i),h(a),m(a),a.useProgram(v),v.uniform3f("ambientColor",n),p(a,i)}}).call(this);