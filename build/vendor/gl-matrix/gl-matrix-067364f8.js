/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
!function(t){"use strict";var n={};"undefined"==typeof exports?"function"==typeof define&&"object"==typeof define.amd&&define.amd?(n.exports={},define(function(){return n.exports})):n.exports="undefined"!=typeof window?window:t:n.exports=exports,function(t){/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
if(!n)var n=1e-6;if(!r)var r="undefined"!=typeof Float32Array?Float32Array:Array;if(!e)var e=Math.random;var a={};a.setMatrixArrayType=function(t){r=t},"undefined"!=typeof t&&(t.glMatrix=a);var u=Math.PI/180;a.toRadian=function(t){return t*u};/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
var o={};o.create=function(){var t=new r(2);return t[0]=0,t[1]=0,t},o.clone=function(t){var n=new r(2);return n[0]=t[0],n[1]=t[1],n},o.fromValues=function(t,n){var e=new r(2);return e[0]=t,e[1]=n,e},o.copy=function(t,n){return t[0]=n[0],t[1]=n[1],t},o.set=function(t,n,r){return t[0]=n,t[1]=r,t},o.add=function(t,n,r){return t[0]=n[0]+r[0],t[1]=n[1]+r[1],t},o.subtract=function(t,n,r){return t[0]=n[0]-r[0],t[1]=n[1]-r[1],t},o.sub=o.subtract,o.multiply=function(t,n,r){return t[0]=n[0]*r[0],t[1]=n[1]*r[1],t},o.mul=o.multiply,o.divide=function(t,n,r){return t[0]=n[0]/r[0],t[1]=n[1]/r[1],t},o.div=o.divide,o.min=function(t,n,r){return t[0]=Math.min(n[0],r[0]),t[1]=Math.min(n[1],r[1]),t},o.max=function(t,n,r){return t[0]=Math.max(n[0],r[0]),t[1]=Math.max(n[1],r[1]),t},o.scale=function(t,n,r){return t[0]=n[0]*r,t[1]=n[1]*r,t},o.scaleAndAdd=function(t,n,r,e){return t[0]=n[0]+r[0]*e,t[1]=n[1]+r[1]*e,t},o.distance=function(t,n){var r=n[0]-t[0],e=n[1]-t[1];return Math.sqrt(r*r+e*e)},o.dist=o.distance,o.squaredDistance=function(t,n){var r=n[0]-t[0],e=n[1]-t[1];return r*r+e*e},o.sqrDist=o.squaredDistance,o.length=function(t){var n=t[0],r=t[1];return Math.sqrt(n*n+r*r)},o.len=o.length,o.squaredLength=function(t){var n=t[0],r=t[1];return n*n+r*r},o.sqrLen=o.squaredLength,o.negate=function(t,n){return t[0]=-n[0],t[1]=-n[1],t},o.inverse=function(t,n){return t[0]=1/n[0],t[1]=1/n[1],t},o.normalize=function(t,n){var r=n[0],e=n[1],a=r*r+e*e;return a>0&&(a=1/Math.sqrt(a),t[0]=n[0]*a,t[1]=n[1]*a),t},o.dot=function(t,n){return t[0]*n[0]+t[1]*n[1]},o.cross=function(t,n,r){var e=n[0]*r[1]-n[1]*r[0];return t[0]=t[1]=0,t[2]=e,t},o.lerp=function(t,n,r,e){var a=n[0],u=n[1];return t[0]=a+e*(r[0]-a),t[1]=u+e*(r[1]-u),t},o.random=function(t,n){n=n||1;var r=2*e()*Math.PI;return t[0]=Math.cos(r)*n,t[1]=Math.sin(r)*n,t},o.transformMat2=function(t,n,r){var e=n[0],a=n[1];return t[0]=r[0]*e+r[2]*a,t[1]=r[1]*e+r[3]*a,t},o.transformMat2d=function(t,n,r){var e=n[0],a=n[1];return t[0]=r[0]*e+r[2]*a+r[4],t[1]=r[1]*e+r[3]*a+r[5],t},o.transformMat3=function(t,n,r){var e=n[0],a=n[1];return t[0]=r[0]*e+r[3]*a+r[6],t[1]=r[1]*e+r[4]*a+r[7],t},o.transformMat4=function(t,n,r){var e=n[0],a=n[1];return t[0]=r[0]*e+r[4]*a+r[12],t[1]=r[1]*e+r[5]*a+r[13],t},o.forEach=function(){var t=o.create();return function(n,r,e,a,u,o){var i,c;for(r||(r=2),e||(e=0),c=a?Math.min(a*r+e,n.length):n.length,i=e;c>i;i+=r)t[0]=n[i],t[1]=n[i+1],u(t,t,o),n[i]=t[0],n[i+1]=t[1];return n}}(),o.str=function(t){return"vec2("+t[0]+", "+t[1]+")"},"undefined"!=typeof t&&(t.vec2=o);/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
var i={};i.create=function(){var t=new r(3);return t[0]=0,t[1]=0,t[2]=0,t},i.clone=function(t){var n=new r(3);return n[0]=t[0],n[1]=t[1],n[2]=t[2],n},i.fromValues=function(t,n,e){var a=new r(3);return a[0]=t,a[1]=n,a[2]=e,a},i.copy=function(t,n){return t[0]=n[0],t[1]=n[1],t[2]=n[2],t},i.set=function(t,n,r,e){return t[0]=n,t[1]=r,t[2]=e,t},i.add=function(t,n,r){return t[0]=n[0]+r[0],t[1]=n[1]+r[1],t[2]=n[2]+r[2],t},i.subtract=function(t,n,r){return t[0]=n[0]-r[0],t[1]=n[1]-r[1],t[2]=n[2]-r[2],t},i.sub=i.subtract,i.multiply=function(t,n,r){return t[0]=n[0]*r[0],t[1]=n[1]*r[1],t[2]=n[2]*r[2],t},i.mul=i.multiply,i.divide=function(t,n,r){return t[0]=n[0]/r[0],t[1]=n[1]/r[1],t[2]=n[2]/r[2],t},i.div=i.divide,i.min=function(t,n,r){return t[0]=Math.min(n[0],r[0]),t[1]=Math.min(n[1],r[1]),t[2]=Math.min(n[2],r[2]),t},i.max=function(t,n,r){return t[0]=Math.max(n[0],r[0]),t[1]=Math.max(n[1],r[1]),t[2]=Math.max(n[2],r[2]),t},i.scale=function(t,n,r){return t[0]=n[0]*r,t[1]=n[1]*r,t[2]=n[2]*r,t},i.scaleAndAdd=function(t,n,r,e){return t[0]=n[0]+r[0]*e,t[1]=n[1]+r[1]*e,t[2]=n[2]+r[2]*e,t},i.distance=function(t,n){var r=n[0]-t[0],e=n[1]-t[1],a=n[2]-t[2];return Math.sqrt(r*r+e*e+a*a)},i.dist=i.distance,i.squaredDistance=function(t,n){var r=n[0]-t[0],e=n[1]-t[1],a=n[2]-t[2];return r*r+e*e+a*a},i.sqrDist=i.squaredDistance,i.length=function(t){var n=t[0],r=t[1],e=t[2];return Math.sqrt(n*n+r*r+e*e)},i.len=i.length,i.squaredLength=function(t){var n=t[0],r=t[1],e=t[2];return n*n+r*r+e*e},i.sqrLen=i.squaredLength,i.negate=function(t,n){return t[0]=-n[0],t[1]=-n[1],t[2]=-n[2],t},i.inverse=function(t,n){return t[0]=1/n[0],t[1]=1/n[1],t[2]=1/n[2],t},i.normalize=function(t,n){var r=n[0],e=n[1],a=n[2],u=r*r+e*e+a*a;return u>0&&(u=1/Math.sqrt(u),t[0]=n[0]*u,t[1]=n[1]*u,t[2]=n[2]*u),t},i.dot=function(t,n){return t[0]*n[0]+t[1]*n[1]+t[2]*n[2]},i.cross=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=r[0],i=r[1],c=r[2];return t[0]=a*c-u*i,t[1]=u*o-e*c,t[2]=e*i-a*o,t},i.lerp=function(t,n,r,e){var a=n[0],u=n[1],o=n[2];return t[0]=a+e*(r[0]-a),t[1]=u+e*(r[1]-u),t[2]=o+e*(r[2]-o),t},i.random=function(t,n){n=n||1;var r=2*e()*Math.PI,a=2*e()-1,u=Math.sqrt(1-a*a)*n;return t[0]=Math.cos(r)*u,t[1]=Math.sin(r)*u,t[2]=a*n,t},i.transformMat4=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=r[3]*e+r[7]*a+r[11]*u+r[15];return o=o||1,t[0]=(r[0]*e+r[4]*a+r[8]*u+r[12])/o,t[1]=(r[1]*e+r[5]*a+r[9]*u+r[13])/o,t[2]=(r[2]*e+r[6]*a+r[10]*u+r[14])/o,t},i.transformMat3=function(t,n,r){var e=n[0],a=n[1],u=n[2];return t[0]=e*r[0]+a*r[3]+u*r[6],t[1]=e*r[1]+a*r[4]+u*r[7],t[2]=e*r[2]+a*r[5]+u*r[8],t},i.transformQuat=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=r[0],i=r[1],c=r[2],f=r[3],s=f*e+i*u-c*a,h=f*a+c*e-o*u,v=f*u+o*a-i*e,M=-o*e-i*a-c*u;return t[0]=s*f+M*-o+h*-c-v*-i,t[1]=h*f+M*-i+v*-o-s*-c,t[2]=v*f+M*-c+s*-i-h*-o,t},i.rotateX=function(t,n,r,e){var a=[],u=[];return a[0]=n[0]-r[0],a[1]=n[1]-r[1],a[2]=n[2]-r[2],u[0]=a[0],u[1]=a[1]*Math.cos(e)-a[2]*Math.sin(e),u[2]=a[1]*Math.sin(e)+a[2]*Math.cos(e),t[0]=u[0]+r[0],t[1]=u[1]+r[1],t[2]=u[2]+r[2],t},i.rotateY=function(t,n,r,e){var a=[],u=[];return a[0]=n[0]-r[0],a[1]=n[1]-r[1],a[2]=n[2]-r[2],u[0]=a[2]*Math.sin(e)+a[0]*Math.cos(e),u[1]=a[1],u[2]=a[2]*Math.cos(e)-a[0]*Math.sin(e),t[0]=u[0]+r[0],t[1]=u[1]+r[1],t[2]=u[2]+r[2],t},i.rotateZ=function(t,n,r,e){var a=[],u=[];return a[0]=n[0]-r[0],a[1]=n[1]-r[1],a[2]=n[2]-r[2],u[0]=a[0]*Math.cos(e)-a[1]*Math.sin(e),u[1]=a[0]*Math.sin(e)+a[1]*Math.cos(e),u[2]=a[2],t[0]=u[0]+r[0],t[1]=u[1]+r[1],t[2]=u[2]+r[2],t},i.forEach=function(){var t=i.create();return function(n,r,e,a,u,o){var i,c;for(r||(r=3),e||(e=0),c=a?Math.min(a*r+e,n.length):n.length,i=e;c>i;i+=r)t[0]=n[i],t[1]=n[i+1],t[2]=n[i+2],u(t,t,o),n[i]=t[0],n[i+1]=t[1],n[i+2]=t[2];return n}}(),i.str=function(t){return"vec3("+t[0]+", "+t[1]+", "+t[2]+")"},"undefined"!=typeof t&&(t.vec3=i);/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
var c={};c.create=function(){var t=new r(4);return t[0]=0,t[1]=0,t[2]=0,t[3]=0,t},c.clone=function(t){var n=new r(4);return n[0]=t[0],n[1]=t[1],n[2]=t[2],n[3]=t[3],n},c.fromValues=function(t,n,e,a){var u=new r(4);return u[0]=t,u[1]=n,u[2]=e,u[3]=a,u},c.copy=function(t,n){return t[0]=n[0],t[1]=n[1],t[2]=n[2],t[3]=n[3],t},c.set=function(t,n,r,e,a){return t[0]=n,t[1]=r,t[2]=e,t[3]=a,t},c.add=function(t,n,r){return t[0]=n[0]+r[0],t[1]=n[1]+r[1],t[2]=n[2]+r[2],t[3]=n[3]+r[3],t},c.subtract=function(t,n,r){return t[0]=n[0]-r[0],t[1]=n[1]-r[1],t[2]=n[2]-r[2],t[3]=n[3]-r[3],t},c.sub=c.subtract,c.multiply=function(t,n,r){return t[0]=n[0]*r[0],t[1]=n[1]*r[1],t[2]=n[2]*r[2],t[3]=n[3]*r[3],t},c.mul=c.multiply,c.divide=function(t,n,r){return t[0]=n[0]/r[0],t[1]=n[1]/r[1],t[2]=n[2]/r[2],t[3]=n[3]/r[3],t},c.div=c.divide,c.min=function(t,n,r){return t[0]=Math.min(n[0],r[0]),t[1]=Math.min(n[1],r[1]),t[2]=Math.min(n[2],r[2]),t[3]=Math.min(n[3],r[3]),t},c.max=function(t,n,r){return t[0]=Math.max(n[0],r[0]),t[1]=Math.max(n[1],r[1]),t[2]=Math.max(n[2],r[2]),t[3]=Math.max(n[3],r[3]),t},c.scale=function(t,n,r){return t[0]=n[0]*r,t[1]=n[1]*r,t[2]=n[2]*r,t[3]=n[3]*r,t},c.scaleAndAdd=function(t,n,r,e){return t[0]=n[0]+r[0]*e,t[1]=n[1]+r[1]*e,t[2]=n[2]+r[2]*e,t[3]=n[3]+r[3]*e,t},c.distance=function(t,n){var r=n[0]-t[0],e=n[1]-t[1],a=n[2]-t[2],u=n[3]-t[3];return Math.sqrt(r*r+e*e+a*a+u*u)},c.dist=c.distance,c.squaredDistance=function(t,n){var r=n[0]-t[0],e=n[1]-t[1],a=n[2]-t[2],u=n[3]-t[3];return r*r+e*e+a*a+u*u},c.sqrDist=c.squaredDistance,c.length=function(t){var n=t[0],r=t[1],e=t[2],a=t[3];return Math.sqrt(n*n+r*r+e*e+a*a)},c.len=c.length,c.squaredLength=function(t){var n=t[0],r=t[1],e=t[2],a=t[3];return n*n+r*r+e*e+a*a},c.sqrLen=c.squaredLength,c.negate=function(t,n){return t[0]=-n[0],t[1]=-n[1],t[2]=-n[2],t[3]=-n[3],t},c.inverse=function(t,n){return t[0]=1/n[0],t[1]=1/n[1],t[2]=1/n[2],t[3]=1/n[3],t},c.normalize=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=r*r+e*e+a*a+u*u;return o>0&&(o=1/Math.sqrt(o),t[0]=n[0]*o,t[1]=n[1]*o,t[2]=n[2]*o,t[3]=n[3]*o),t},c.dot=function(t,n){return t[0]*n[0]+t[1]*n[1]+t[2]*n[2]+t[3]*n[3]},c.lerp=function(t,n,r,e){var a=n[0],u=n[1],o=n[2],i=n[3];return t[0]=a+e*(r[0]-a),t[1]=u+e*(r[1]-u),t[2]=o+e*(r[2]-o),t[3]=i+e*(r[3]-i),t},c.random=function(t,n){return n=n||1,t[0]=e(),t[1]=e(),t[2]=e(),t[3]=e(),c.normalize(t,t),c.scale(t,t,n),t},c.transformMat4=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3];return t[0]=r[0]*e+r[4]*a+r[8]*u+r[12]*o,t[1]=r[1]*e+r[5]*a+r[9]*u+r[13]*o,t[2]=r[2]*e+r[6]*a+r[10]*u+r[14]*o,t[3]=r[3]*e+r[7]*a+r[11]*u+r[15]*o,t},c.transformQuat=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=r[0],i=r[1],c=r[2],f=r[3],s=f*e+i*u-c*a,h=f*a+c*e-o*u,v=f*u+o*a-i*e,M=-o*e-i*a-c*u;return t[0]=s*f+M*-o+h*-c-v*-i,t[1]=h*f+M*-i+v*-o-s*-c,t[2]=v*f+M*-c+s*-i-h*-o,t},c.forEach=function(){var t=c.create();return function(n,r,e,a,u,o){var i,c;for(r||(r=4),e||(e=0),c=a?Math.min(a*r+e,n.length):n.length,i=e;c>i;i+=r)t[0]=n[i],t[1]=n[i+1],t[2]=n[i+2],t[3]=n[i+3],u(t,t,o),n[i]=t[0],n[i+1]=t[1],n[i+2]=t[2],n[i+3]=t[3];return n}}(),c.str=function(t){return"vec4("+t[0]+", "+t[1]+", "+t[2]+", "+t[3]+")"},"undefined"!=typeof t&&(t.vec4=c);/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
var f={};f.create=function(){var t=new r(4);return t[0]=1,t[1]=0,t[2]=0,t[3]=1,t},f.clone=function(t){var n=new r(4);return n[0]=t[0],n[1]=t[1],n[2]=t[2],n[3]=t[3],n},f.copy=function(t,n){return t[0]=n[0],t[1]=n[1],t[2]=n[2],t[3]=n[3],t},f.identity=function(t){return t[0]=1,t[1]=0,t[2]=0,t[3]=1,t},f.transpose=function(t,n){if(t===n){var r=n[1];t[1]=n[2],t[2]=r}else t[0]=n[0],t[1]=n[2],t[2]=n[1],t[3]=n[3];return t},f.invert=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=r*u-a*e;return o?(o=1/o,t[0]=u*o,t[1]=-e*o,t[2]=-a*o,t[3]=r*o,t):null},f.adjoint=function(t,n){var r=n[0];return t[0]=n[3],t[1]=-n[1],t[2]=-n[2],t[3]=r,t},f.determinant=function(t){return t[0]*t[3]-t[2]*t[1]},f.multiply=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=r[0],c=r[1],f=r[2],s=r[3];return t[0]=e*i+u*c,t[1]=a*i+o*c,t[2]=e*f+u*s,t[3]=a*f+o*s,t},f.mul=f.multiply,f.rotate=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=Math.sin(r),c=Math.cos(r);return t[0]=e*c+u*i,t[1]=a*c+o*i,t[2]=e*-i+u*c,t[3]=a*-i+o*c,t},f.scale=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=r[0],c=r[1];return t[0]=e*i,t[1]=a*i,t[2]=u*c,t[3]=o*c,t},f.str=function(t){return"mat2("+t[0]+", "+t[1]+", "+t[2]+", "+t[3]+")"},f.frob=function(t){return Math.sqrt(Math.pow(t[0],2)+Math.pow(t[1],2)+Math.pow(t[2],2)+Math.pow(t[3],2))},f.LDU=function(t,n,r,e){return t[2]=e[2]/e[0],r[0]=e[0],r[1]=e[1],r[3]=e[3]-t[2]*r[1],[t,n,r]},"undefined"!=typeof t&&(t.mat2=f);/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
var s={};s.create=function(){var t=new r(6);return t[0]=1,t[1]=0,t[2]=0,t[3]=1,t[4]=0,t[5]=0,t},s.clone=function(t){var n=new r(6);return n[0]=t[0],n[1]=t[1],n[2]=t[2],n[3]=t[3],n[4]=t[4],n[5]=t[5],n},s.copy=function(t,n){return t[0]=n[0],t[1]=n[1],t[2]=n[2],t[3]=n[3],t[4]=n[4],t[5]=n[5],t},s.identity=function(t){return t[0]=1,t[1]=0,t[2]=0,t[3]=1,t[4]=0,t[5]=0,t},s.invert=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=n[4],i=n[5],c=r*u-e*a;return c?(c=1/c,t[0]=u*c,t[1]=-e*c,t[2]=-a*c,t[3]=r*c,t[4]=(a*i-u*o)*c,t[5]=(e*o-r*i)*c,t):null},s.determinant=function(t){return t[0]*t[3]-t[1]*t[2]},s.multiply=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=n[4],c=n[5],f=r[0],s=r[1],h=r[2],v=r[3],M=r[4],l=r[5];return t[0]=e*f+u*s,t[1]=a*f+o*s,t[2]=e*h+u*v,t[3]=a*h+o*v,t[4]=e*M+u*l+i,t[5]=a*M+o*l+c,t},s.mul=s.multiply,s.rotate=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=n[4],c=n[5],f=Math.sin(r),s=Math.cos(r);return t[0]=e*s+u*f,t[1]=a*s+o*f,t[2]=e*-f+u*s,t[3]=a*-f+o*s,t[4]=i,t[5]=c,t},s.scale=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=n[4],c=n[5],f=r[0],s=r[1];return t[0]=e*f,t[1]=a*f,t[2]=u*s,t[3]=o*s,t[4]=i,t[5]=c,t},s.translate=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=n[4],c=n[5],f=r[0],s=r[1];return t[0]=e,t[1]=a,t[2]=u,t[3]=o,t[4]=e*f+u*s+i,t[5]=a*f+o*s+c,t},s.str=function(t){return"mat2d("+t[0]+", "+t[1]+", "+t[2]+", "+t[3]+", "+t[4]+", "+t[5]+")"},s.frob=function(t){return Math.sqrt(Math.pow(t[0],2)+Math.pow(t[1],2)+Math.pow(t[2],2)+Math.pow(t[3],2)+Math.pow(t[4],2)+Math.pow(t[5],2)+1)},"undefined"!=typeof t&&(t.mat2d=s);/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
var h={};h.create=function(){var t=new r(9);return t[0]=1,t[1]=0,t[2]=0,t[3]=0,t[4]=1,t[5]=0,t[6]=0,t[7]=0,t[8]=1,t},h.fromMat4=function(t,n){return t[0]=n[0],t[1]=n[1],t[2]=n[2],t[3]=n[4],t[4]=n[5],t[5]=n[6],t[6]=n[8],t[7]=n[9],t[8]=n[10],t},h.clone=function(t){var n=new r(9);return n[0]=t[0],n[1]=t[1],n[2]=t[2],n[3]=t[3],n[4]=t[4],n[5]=t[5],n[6]=t[6],n[7]=t[7],n[8]=t[8],n},h.copy=function(t,n){return t[0]=n[0],t[1]=n[1],t[2]=n[2],t[3]=n[3],t[4]=n[4],t[5]=n[5],t[6]=n[6],t[7]=n[7],t[8]=n[8],t},h.identity=function(t){return t[0]=1,t[1]=0,t[2]=0,t[3]=0,t[4]=1,t[5]=0,t[6]=0,t[7]=0,t[8]=1,t},h.transpose=function(t,n){if(t===n){var r=n[1],e=n[2],a=n[5];t[1]=n[3],t[2]=n[6],t[3]=r,t[5]=n[7],t[6]=e,t[7]=a}else t[0]=n[0],t[1]=n[3],t[2]=n[6],t[3]=n[1],t[4]=n[4],t[5]=n[7],t[6]=n[2],t[7]=n[5],t[8]=n[8];return t},h.invert=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=n[4],i=n[5],c=n[6],f=n[7],s=n[8],h=s*o-i*f,v=-s*u+i*c,M=f*u-o*c,l=r*h+e*v+a*M;return l?(l=1/l,t[0]=h*l,t[1]=(-s*e+a*f)*l,t[2]=(i*e-a*o)*l,t[3]=v*l,t[4]=(s*r-a*c)*l,t[5]=(-i*r+a*u)*l,t[6]=M*l,t[7]=(-f*r+e*c)*l,t[8]=(o*r-e*u)*l,t):null},h.adjoint=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=n[4],i=n[5],c=n[6],f=n[7],s=n[8];return t[0]=o*s-i*f,t[1]=a*f-e*s,t[2]=e*i-a*o,t[3]=i*c-u*s,t[4]=r*s-a*c,t[5]=a*u-r*i,t[6]=u*f-o*c,t[7]=e*c-r*f,t[8]=r*o-e*u,t},h.determinant=function(t){var n=t[0],r=t[1],e=t[2],a=t[3],u=t[4],o=t[5],i=t[6],c=t[7],f=t[8];return n*(f*u-o*c)+r*(-f*a+o*i)+e*(c*a-u*i)},h.multiply=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=n[4],c=n[5],f=n[6],s=n[7],h=n[8],v=r[0],M=r[1],l=r[2],d=r[3],m=r[4],p=r[5],w=r[6],y=r[7],q=r[8];return t[0]=v*e+M*o+l*f,t[1]=v*a+M*i+l*s,t[2]=v*u+M*c+l*h,t[3]=d*e+m*o+p*f,t[4]=d*a+m*i+p*s,t[5]=d*u+m*c+p*h,t[6]=w*e+y*o+q*f,t[7]=w*a+y*i+q*s,t[8]=w*u+y*c+q*h,t},h.mul=h.multiply,h.translate=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=n[4],c=n[5],f=n[6],s=n[7],h=n[8],v=r[0],M=r[1];return t[0]=e,t[1]=a,t[2]=u,t[3]=o,t[4]=i,t[5]=c,t[6]=v*e+M*o+f,t[7]=v*a+M*i+s,t[8]=v*u+M*c+h,t},h.rotate=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=n[4],c=n[5],f=n[6],s=n[7],h=n[8],v=Math.sin(r),M=Math.cos(r);return t[0]=M*e+v*o,t[1]=M*a+v*i,t[2]=M*u+v*c,t[3]=M*o-v*e,t[4]=M*i-v*a,t[5]=M*c-v*u,t[6]=f,t[7]=s,t[8]=h,t},h.scale=function(t,n,r){var e=r[0],a=r[1];return t[0]=e*n[0],t[1]=e*n[1],t[2]=e*n[2],t[3]=a*n[3],t[4]=a*n[4],t[5]=a*n[5],t[6]=n[6],t[7]=n[7],t[8]=n[8],t},h.fromMat2d=function(t,n){return t[0]=n[0],t[1]=n[1],t[2]=0,t[3]=n[2],t[4]=n[3],t[5]=0,t[6]=n[4],t[7]=n[5],t[8]=1,t},h.fromQuat=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=r+r,i=e+e,c=a+a,f=r*o,s=e*o,h=e*i,v=a*o,M=a*i,l=a*c,d=u*o,m=u*i,p=u*c;return t[0]=1-h-l,t[3]=s-p,t[6]=v+m,t[1]=s+p,t[4]=1-f-l,t[7]=M-d,t[2]=v-m,t[5]=M+d,t[8]=1-f-h,t},h.normalFromMat4=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=n[4],i=n[5],c=n[6],f=n[7],s=n[8],h=n[9],v=n[10],M=n[11],l=n[12],d=n[13],m=n[14],p=n[15],w=r*i-e*o,y=r*c-a*o,q=r*f-u*o,g=e*c-a*i,x=e*f-u*i,b=a*f-u*c,A=s*d-h*l,L=s*m-v*l,D=s*p-M*l,z=h*m-v*d,V=h*p-M*d,j=v*p-M*m,I=w*j-y*V+q*z+g*D-x*L+b*A;return I?(I=1/I,t[0]=(i*j-c*V+f*z)*I,t[1]=(c*D-o*j-f*L)*I,t[2]=(o*V-i*D+f*A)*I,t[3]=(a*V-e*j-u*z)*I,t[4]=(r*j-a*D+u*L)*I,t[5]=(e*D-r*V-u*A)*I,t[6]=(d*b-m*x+p*g)*I,t[7]=(m*q-l*b-p*y)*I,t[8]=(l*x-d*q+p*w)*I,t):null},h.str=function(t){return"mat3("+t[0]+", "+t[1]+", "+t[2]+", "+t[3]+", "+t[4]+", "+t[5]+", "+t[6]+", "+t[7]+", "+t[8]+")"},h.frob=function(t){return Math.sqrt(Math.pow(t[0],2)+Math.pow(t[1],2)+Math.pow(t[2],2)+Math.pow(t[3],2)+Math.pow(t[4],2)+Math.pow(t[5],2)+Math.pow(t[6],2)+Math.pow(t[7],2)+Math.pow(t[8],2))},"undefined"!=typeof t&&(t.mat3=h);/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
var v={};v.create=function(){var t=new r(16);return t[0]=1,t[1]=0,t[2]=0,t[3]=0,t[4]=0,t[5]=1,t[6]=0,t[7]=0,t[8]=0,t[9]=0,t[10]=1,t[11]=0,t[12]=0,t[13]=0,t[14]=0,t[15]=1,t},v.clone=function(t){var n=new r(16);return n[0]=t[0],n[1]=t[1],n[2]=t[2],n[3]=t[3],n[4]=t[4],n[5]=t[5],n[6]=t[6],n[7]=t[7],n[8]=t[8],n[9]=t[9],n[10]=t[10],n[11]=t[11],n[12]=t[12],n[13]=t[13],n[14]=t[14],n[15]=t[15],n},v.copy=function(t,n){return t[0]=n[0],t[1]=n[1],t[2]=n[2],t[3]=n[3],t[4]=n[4],t[5]=n[5],t[6]=n[6],t[7]=n[7],t[8]=n[8],t[9]=n[9],t[10]=n[10],t[11]=n[11],t[12]=n[12],t[13]=n[13],t[14]=n[14],t[15]=n[15],t},v.identity=function(t){return t[0]=1,t[1]=0,t[2]=0,t[3]=0,t[4]=0,t[5]=1,t[6]=0,t[7]=0,t[8]=0,t[9]=0,t[10]=1,t[11]=0,t[12]=0,t[13]=0,t[14]=0,t[15]=1,t},v.transpose=function(t,n){if(t===n){var r=n[1],e=n[2],a=n[3],u=n[6],o=n[7],i=n[11];t[1]=n[4],t[2]=n[8],t[3]=n[12],t[4]=r,t[6]=n[9],t[7]=n[13],t[8]=e,t[9]=u,t[11]=n[14],t[12]=a,t[13]=o,t[14]=i}else t[0]=n[0],t[1]=n[4],t[2]=n[8],t[3]=n[12],t[4]=n[1],t[5]=n[5],t[6]=n[9],t[7]=n[13],t[8]=n[2],t[9]=n[6],t[10]=n[10],t[11]=n[14],t[12]=n[3],t[13]=n[7],t[14]=n[11],t[15]=n[15];return t},v.invert=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=n[4],i=n[5],c=n[6],f=n[7],s=n[8],h=n[9],v=n[10],M=n[11],l=n[12],d=n[13],m=n[14],p=n[15],w=r*i-e*o,y=r*c-a*o,q=r*f-u*o,g=e*c-a*i,x=e*f-u*i,b=a*f-u*c,A=s*d-h*l,L=s*m-v*l,D=s*p-M*l,z=h*m-v*d,V=h*p-M*d,j=v*p-M*m,I=w*j-y*V+q*z+g*D-x*L+b*A;return I?(I=1/I,t[0]=(i*j-c*V+f*z)*I,t[1]=(a*V-e*j-u*z)*I,t[2]=(d*b-m*x+p*g)*I,t[3]=(v*x-h*b-M*g)*I,t[4]=(c*D-o*j-f*L)*I,t[5]=(r*j-a*D+u*L)*I,t[6]=(m*q-l*b-p*y)*I,t[7]=(s*b-v*q+M*y)*I,t[8]=(o*V-i*D+f*A)*I,t[9]=(e*D-r*V-u*A)*I,t[10]=(l*x-d*q+p*w)*I,t[11]=(h*q-s*x-M*w)*I,t[12]=(i*L-o*z-c*A)*I,t[13]=(r*z-e*L+a*A)*I,t[14]=(d*y-l*g-m*w)*I,t[15]=(s*g-h*y+v*w)*I,t):null},v.adjoint=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=n[4],i=n[5],c=n[6],f=n[7],s=n[8],h=n[9],v=n[10],M=n[11],l=n[12],d=n[13],m=n[14],p=n[15];return t[0]=i*(v*p-M*m)-h*(c*p-f*m)+d*(c*M-f*v),t[1]=-(e*(v*p-M*m)-h*(a*p-u*m)+d*(a*M-u*v)),t[2]=e*(c*p-f*m)-i*(a*p-u*m)+d*(a*f-u*c),t[3]=-(e*(c*M-f*v)-i*(a*M-u*v)+h*(a*f-u*c)),t[4]=-(o*(v*p-M*m)-s*(c*p-f*m)+l*(c*M-f*v)),t[5]=r*(v*p-M*m)-s*(a*p-u*m)+l*(a*M-u*v),t[6]=-(r*(c*p-f*m)-o*(a*p-u*m)+l*(a*f-u*c)),t[7]=r*(c*M-f*v)-o*(a*M-u*v)+s*(a*f-u*c),t[8]=o*(h*p-M*d)-s*(i*p-f*d)+l*(i*M-f*h),t[9]=-(r*(h*p-M*d)-s*(e*p-u*d)+l*(e*M-u*h)),t[10]=r*(i*p-f*d)-o*(e*p-u*d)+l*(e*f-u*i),t[11]=-(r*(i*M-f*h)-o*(e*M-u*h)+s*(e*f-u*i)),t[12]=-(o*(h*m-v*d)-s*(i*m-c*d)+l*(i*v-c*h)),t[13]=r*(h*m-v*d)-s*(e*m-a*d)+l*(e*v-a*h),t[14]=-(r*(i*m-c*d)-o*(e*m-a*d)+l*(e*c-a*i)),t[15]=r*(i*v-c*h)-o*(e*v-a*h)+s*(e*c-a*i),t},v.determinant=function(t){var n=t[0],r=t[1],e=t[2],a=t[3],u=t[4],o=t[5],i=t[6],c=t[7],f=t[8],s=t[9],h=t[10],v=t[11],M=t[12],l=t[13],d=t[14],m=t[15],p=n*o-r*u,w=n*i-e*u,y=n*c-a*u,q=r*i-e*o,g=r*c-a*o,x=e*c-a*i,b=f*l-s*M,A=f*d-h*M,L=f*m-v*M,D=s*d-h*l,z=s*m-v*l,V=h*m-v*d;return p*V-w*z+y*D+q*L-g*A+x*b},v.multiply=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=n[4],c=n[5],f=n[6],s=n[7],h=n[8],v=n[9],M=n[10],l=n[11],d=n[12],m=n[13],p=n[14],w=n[15],y=r[0],q=r[1],g=r[2],x=r[3];return t[0]=y*e+q*i+g*h+x*d,t[1]=y*a+q*c+g*v+x*m,t[2]=y*u+q*f+g*M+x*p,t[3]=y*o+q*s+g*l+x*w,y=r[4],q=r[5],g=r[6],x=r[7],t[4]=y*e+q*i+g*h+x*d,t[5]=y*a+q*c+g*v+x*m,t[6]=y*u+q*f+g*M+x*p,t[7]=y*o+q*s+g*l+x*w,y=r[8],q=r[9],g=r[10],x=r[11],t[8]=y*e+q*i+g*h+x*d,t[9]=y*a+q*c+g*v+x*m,t[10]=y*u+q*f+g*M+x*p,t[11]=y*o+q*s+g*l+x*w,y=r[12],q=r[13],g=r[14],x=r[15],t[12]=y*e+q*i+g*h+x*d,t[13]=y*a+q*c+g*v+x*m,t[14]=y*u+q*f+g*M+x*p,t[15]=y*o+q*s+g*l+x*w,t},v.mul=v.multiply,v.translate=function(t,n,r){var e,a,u,o,i,c,f,s,h,v,M,l,d=r[0],m=r[1],p=r[2];return n===t?(t[12]=n[0]*d+n[4]*m+n[8]*p+n[12],t[13]=n[1]*d+n[5]*m+n[9]*p+n[13],t[14]=n[2]*d+n[6]*m+n[10]*p+n[14],t[15]=n[3]*d+n[7]*m+n[11]*p+n[15]):(e=n[0],a=n[1],u=n[2],o=n[3],i=n[4],c=n[5],f=n[6],s=n[7],h=n[8],v=n[9],M=n[10],l=n[11],t[0]=e,t[1]=a,t[2]=u,t[3]=o,t[4]=i,t[5]=c,t[6]=f,t[7]=s,t[8]=h,t[9]=v,t[10]=M,t[11]=l,t[12]=e*d+i*m+h*p+n[12],t[13]=a*d+c*m+v*p+n[13],t[14]=u*d+f*m+M*p+n[14],t[15]=o*d+s*m+l*p+n[15]),t},v.scale=function(t,n,r){var e=r[0],a=r[1],u=r[2];return t[0]=n[0]*e,t[1]=n[1]*e,t[2]=n[2]*e,t[3]=n[3]*e,t[4]=n[4]*a,t[5]=n[5]*a,t[6]=n[6]*a,t[7]=n[7]*a,t[8]=n[8]*u,t[9]=n[9]*u,t[10]=n[10]*u,t[11]=n[11]*u,t[12]=n[12],t[13]=n[13],t[14]=n[14],t[15]=n[15],t},v.rotate=function(t,r,e,a){var u,o,i,c,f,s,h,v,M,l,d,m,p,w,y,q,g,x,b,A,L,D,z,V,j=a[0],I=a[1],P=a[2],Q=Math.sqrt(j*j+I*I+P*P);return Math.abs(Q)<n?null:(Q=1/Q,j*=Q,I*=Q,P*=Q,u=Math.sin(e),o=Math.cos(e),i=1-o,c=r[0],f=r[1],s=r[2],h=r[3],v=r[4],M=r[5],l=r[6],d=r[7],m=r[8],p=r[9],w=r[10],y=r[11],q=j*j*i+o,g=I*j*i+P*u,x=P*j*i-I*u,b=j*I*i-P*u,A=I*I*i+o,L=P*I*i+j*u,D=j*P*i+I*u,z=I*P*i-j*u,V=P*P*i+o,t[0]=c*q+v*g+m*x,t[1]=f*q+M*g+p*x,t[2]=s*q+l*g+w*x,t[3]=h*q+d*g+y*x,t[4]=c*b+v*A+m*L,t[5]=f*b+M*A+p*L,t[6]=s*b+l*A+w*L,t[7]=h*b+d*A+y*L,t[8]=c*D+v*z+m*V,t[9]=f*D+M*z+p*V,t[10]=s*D+l*z+w*V,t[11]=h*D+d*z+y*V,r!==t&&(t[12]=r[12],t[13]=r[13],t[14]=r[14],t[15]=r[15]),t)},v.rotateX=function(t,n,r){var e=Math.sin(r),a=Math.cos(r),u=n[4],o=n[5],i=n[6],c=n[7],f=n[8],s=n[9],h=n[10],v=n[11];return n!==t&&(t[0]=n[0],t[1]=n[1],t[2]=n[2],t[3]=n[3],t[12]=n[12],t[13]=n[13],t[14]=n[14],t[15]=n[15]),t[4]=u*a+f*e,t[5]=o*a+s*e,t[6]=i*a+h*e,t[7]=c*a+v*e,t[8]=f*a-u*e,t[9]=s*a-o*e,t[10]=h*a-i*e,t[11]=v*a-c*e,t},v.rotateY=function(t,n,r){var e=Math.sin(r),a=Math.cos(r),u=n[0],o=n[1],i=n[2],c=n[3],f=n[8],s=n[9],h=n[10],v=n[11];return n!==t&&(t[4]=n[4],t[5]=n[5],t[6]=n[6],t[7]=n[7],t[12]=n[12],t[13]=n[13],t[14]=n[14],t[15]=n[15]),t[0]=u*a-f*e,t[1]=o*a-s*e,t[2]=i*a-h*e,t[3]=c*a-v*e,t[8]=u*e+f*a,t[9]=o*e+s*a,t[10]=i*e+h*a,t[11]=c*e+v*a,t},v.rotateZ=function(t,n,r){var e=Math.sin(r),a=Math.cos(r),u=n[0],o=n[1],i=n[2],c=n[3],f=n[4],s=n[5],h=n[6],v=n[7];return n!==t&&(t[8]=n[8],t[9]=n[9],t[10]=n[10],t[11]=n[11],t[12]=n[12],t[13]=n[13],t[14]=n[14],t[15]=n[15]),t[0]=u*a+f*e,t[1]=o*a+s*e,t[2]=i*a+h*e,t[3]=c*a+v*e,t[4]=f*a-u*e,t[5]=s*a-o*e,t[6]=h*a-i*e,t[7]=v*a-c*e,t},v.fromRotationTranslation=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=e+e,c=a+a,f=u+u,s=e*i,h=e*c,v=e*f,M=a*c,l=a*f,d=u*f,m=o*i,p=o*c,w=o*f;return t[0]=1-(M+d),t[1]=h+w,t[2]=v-p,t[3]=0,t[4]=h-w,t[5]=1-(s+d),t[6]=l+m,t[7]=0,t[8]=v+p,t[9]=l-m,t[10]=1-(s+M),t[11]=0,t[12]=r[0],t[13]=r[1],t[14]=r[2],t[15]=1,t},v.fromQuat=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=r+r,i=e+e,c=a+a,f=r*o,s=e*o,h=e*i,v=a*o,M=a*i,l=a*c,d=u*o,m=u*i,p=u*c;return t[0]=1-h-l,t[1]=s+p,t[2]=v-m,t[3]=0,t[4]=s-p,t[5]=1-f-l,t[6]=M+d,t[7]=0,t[8]=v+m,t[9]=M-d,t[10]=1-f-h,t[11]=0,t[12]=0,t[13]=0,t[14]=0,t[15]=1,t},v.frustum=function(t,n,r,e,a,u,o){var i=1/(r-n),c=1/(a-e),f=1/(u-o);return t[0]=2*u*i,t[1]=0,t[2]=0,t[3]=0,t[4]=0,t[5]=2*u*c,t[6]=0,t[7]=0,t[8]=(r+n)*i,t[9]=(a+e)*c,t[10]=(o+u)*f,t[11]=-1,t[12]=0,t[13]=0,t[14]=o*u*2*f,t[15]=0,t},v.perspective=function(t,n,r,e,a){var u=1/Math.tan(n/2),o=1/(e-a);return t[0]=u/r,t[1]=0,t[2]=0,t[3]=0,t[4]=0,t[5]=u,t[6]=0,t[7]=0,t[8]=0,t[9]=0,t[10]=(a+e)*o,t[11]=-1,t[12]=0,t[13]=0,t[14]=2*a*e*o,t[15]=0,t},v.ortho=function(t,n,r,e,a,u,o){var i=1/(n-r),c=1/(e-a),f=1/(u-o);return t[0]=-2*i,t[1]=0,t[2]=0,t[3]=0,t[4]=0,t[5]=-2*c,t[6]=0,t[7]=0,t[8]=0,t[9]=0,t[10]=2*f,t[11]=0,t[12]=(n+r)*i,t[13]=(a+e)*c,t[14]=(o+u)*f,t[15]=1,t},v.lookAt=function(t,r,e,a){var u,o,i,c,f,s,h,M,l,d,m=r[0],p=r[1],w=r[2],y=a[0],q=a[1],g=a[2],x=e[0],b=e[1],A=e[2];return Math.abs(m-x)<n&&Math.abs(p-b)<n&&Math.abs(w-A)<n?v.identity(t):(h=m-x,M=p-b,l=w-A,d=1/Math.sqrt(h*h+M*M+l*l),h*=d,M*=d,l*=d,u=q*l-g*M,o=g*h-y*l,i=y*M-q*h,d=Math.sqrt(u*u+o*o+i*i),d?(d=1/d,u*=d,o*=d,i*=d):(u=0,o=0,i=0),c=M*i-l*o,f=l*u-h*i,s=h*o-M*u,d=Math.sqrt(c*c+f*f+s*s),d?(d=1/d,c*=d,f*=d,s*=d):(c=0,f=0,s=0),t[0]=u,t[1]=c,t[2]=h,t[3]=0,t[4]=o,t[5]=f,t[6]=M,t[7]=0,t[8]=i,t[9]=s,t[10]=l,t[11]=0,t[12]=-(u*m+o*p+i*w),t[13]=-(c*m+f*p+s*w),t[14]=-(h*m+M*p+l*w),t[15]=1,t)},v.str=function(t){return"mat4("+t[0]+", "+t[1]+", "+t[2]+", "+t[3]+", "+t[4]+", "+t[5]+", "+t[6]+", "+t[7]+", "+t[8]+", "+t[9]+", "+t[10]+", "+t[11]+", "+t[12]+", "+t[13]+", "+t[14]+", "+t[15]+")"},v.frob=function(t){return Math.sqrt(Math.pow(t[0],2)+Math.pow(t[1],2)+Math.pow(t[2],2)+Math.pow(t[3],2)+Math.pow(t[4],2)+Math.pow(t[5],2)+Math.pow(t[6],2)+Math.pow(t[7],2)+Math.pow(t[8],2)+Math.pow(t[9],2)+Math.pow(t[10],2)+Math.pow(t[11],2)+Math.pow(t[12],2)+Math.pow(t[13],2)+Math.pow(t[14],2)+Math.pow(t[15],2))},"undefined"!=typeof t&&(t.mat4=v);/* Copyright (c) 2013, Brandon Jones, Colin MacKenzie IV. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */
var M={};M.create=function(){var t=new r(4);return t[0]=0,t[1]=0,t[2]=0,t[3]=1,t},M.rotationTo=function(){var t=i.create(),n=i.fromValues(1,0,0),r=i.fromValues(0,1,0);return function(e,a,u){var o=i.dot(a,u);return-.999999>o?(i.cross(t,n,a),i.length(t)<1e-6&&i.cross(t,r,a),i.normalize(t,t),M.setAxisAngle(e,t,Math.PI),e):o>.999999?(e[0]=0,e[1]=0,e[2]=0,e[3]=1,e):(i.cross(t,a,u),e[0]=t[0],e[1]=t[1],e[2]=t[2],e[3]=1+o,M.normalize(e,e))}}(),M.setAxes=function(){var t=h.create();return function(n,r,e,a){return t[0]=e[0],t[3]=e[1],t[6]=e[2],t[1]=a[0],t[4]=a[1],t[7]=a[2],t[2]=-r[0],t[5]=-r[1],t[8]=-r[2],M.normalize(n,M.fromMat3(n,t))}}(),M.clone=c.clone,M.fromValues=c.fromValues,M.copy=c.copy,M.set=c.set,M.identity=function(t){return t[0]=0,t[1]=0,t[2]=0,t[3]=1,t},M.setAxisAngle=function(t,n,r){r=.5*r;var e=Math.sin(r);return t[0]=e*n[0],t[1]=e*n[1],t[2]=e*n[2],t[3]=Math.cos(r),t},M.add=c.add,M.multiply=function(t,n,r){var e=n[0],a=n[1],u=n[2],o=n[3],i=r[0],c=r[1],f=r[2],s=r[3];return t[0]=e*s+o*i+a*f-u*c,t[1]=a*s+o*c+u*i-e*f,t[2]=u*s+o*f+e*c-a*i,t[3]=o*s-e*i-a*c-u*f,t},M.mul=M.multiply,M.scale=c.scale,M.rotateX=function(t,n,r){r*=.5;var e=n[0],a=n[1],u=n[2],o=n[3],i=Math.sin(r),c=Math.cos(r);return t[0]=e*c+o*i,t[1]=a*c+u*i,t[2]=u*c-a*i,t[3]=o*c-e*i,t},M.rotateY=function(t,n,r){r*=.5;var e=n[0],a=n[1],u=n[2],o=n[3],i=Math.sin(r),c=Math.cos(r);return t[0]=e*c-u*i,t[1]=a*c+o*i,t[2]=u*c+e*i,t[3]=o*c-a*i,t},M.rotateZ=function(t,n,r){r*=.5;var e=n[0],a=n[1],u=n[2],o=n[3],i=Math.sin(r),c=Math.cos(r);return t[0]=e*c+a*i,t[1]=a*c-e*i,t[2]=u*c+o*i,t[3]=o*c-u*i,t},M.calculateW=function(t,n){var r=n[0],e=n[1],a=n[2];return t[0]=r,t[1]=e,t[2]=a,t[3]=Math.sqrt(Math.abs(1-r*r-e*e-a*a)),t},M.dot=c.dot,M.lerp=c.lerp,M.slerp=function(t,n,r,e){var a,u,o,i,c,f=n[0],s=n[1],h=n[2],v=n[3],M=r[0],l=r[1],d=r[2],m=r[3];return u=f*M+s*l+h*d+v*m,0>u&&(u=-u,M=-M,l=-l,d=-d,m=-m),1-u>1e-6?(a=Math.acos(u),o=Math.sin(a),i=Math.sin((1-e)*a)/o,c=Math.sin(e*a)/o):(i=1-e,c=e),t[0]=i*f+c*M,t[1]=i*s+c*l,t[2]=i*h+c*d,t[3]=i*v+c*m,t},M.invert=function(t,n){var r=n[0],e=n[1],a=n[2],u=n[3],o=r*r+e*e+a*a+u*u,i=o?1/o:0;return t[0]=-r*i,t[1]=-e*i,t[2]=-a*i,t[3]=u*i,t},M.conjugate=function(t,n){return t[0]=-n[0],t[1]=-n[1],t[2]=-n[2],t[3]=n[3],t},M.length=c.length,M.len=M.length,M.squaredLength=c.squaredLength,M.sqrLen=M.squaredLength,M.normalize=c.normalize,M.fromMat3=function(t,n){var r,e=n[0]+n[4]+n[8];if(e>0)r=Math.sqrt(e+1),t[3]=.5*r,r=.5/r,t[0]=(n[5]-n[7])*r,t[1]=(n[6]-n[2])*r,t[2]=(n[1]-n[3])*r;else{var a=0;n[4]>n[0]&&(a=1),n[8]>n[3*a+a]&&(a=2);var u=(a+1)%3,o=(a+2)%3;r=Math.sqrt(n[3*a+a]-n[3*u+u]-n[3*o+o]+1),t[a]=.5*r,r=.5/r,t[3]=(n[3*u+o]-n[3*o+u])*r,t[u]=(n[3*u+a]+n[3*a+u])*r,t[o]=(n[3*o+a]+n[3*a+o])*r}return t},M.str=function(t){return"quat("+t[0]+", "+t[1]+", "+t[2]+", "+t[3]+")"},"undefined"!=typeof t&&(t.quat=M)}(n.exports)}(this);