#include "/node_modules/lygia/generative/cnoise.glsl"

uniform float iTime;
uniform vec3 iResolution;
uniform vec4 iMouse;
uniform float uDistort;

varying vec2 vUv;
varying float vNoise;
varying vec3 vNormal;
varying vec3 vWorldPosition;


vec3 distort(vec3 p){
    float noise=cnoise(p+iTime);
    vNoise=noise;
    p+=noise*normal*.3*uDistort;
    return p;
}

void main(){
    vec3 p=position;
    p=distort(p);
    gl_Position=projectionMatrix*modelViewMatrix*vec4(p,1.);
    
    vUv=uv;
    vNormal=normal;
    vWorldPosition=(modelMatrix*vec4(p,1.)).xyz;
}