#include "/node_modules/lygia/generative/cnoise.glsl"
uniform float iTime;
uniform float uDistort;

varying vec2 vUv;

vec3 distort(vec3 p){
    float noise=cnoise(p+iTime);
    p+=noise * normal *.3 * uDistort;
    return p;
}


void main() {
  vec3 p = position;
 p = distort(p);


  vec4 modelViewPosition = modelViewMatrix * vec4(p, 1.0);
  vec4 projectedPosition = projectionMatrix * modelViewPosition;


  gl_Position = projectedPosition;
  vUv = uv;
}