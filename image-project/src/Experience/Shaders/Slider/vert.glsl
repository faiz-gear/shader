#include "/node_modules/lygia/math/const.glsl"

uniform float iTime;
uniform vec3 iResolution;
uniform vec4 iMouse;

varying vec2 vUv;

vec3 distort(vec3 p){
  p.x += sin(uv.y*PI)*100.;
  return p;
}

void main(){
    vec3 p=position;
    vec4 mvPosition=modelViewMatrix*vec4(p,1.);
    mvPosition.xyz=distort(mvPosition.xyz);
    gl_Position=projectionMatrix*mvPosition;

    vUv=uv;
}
