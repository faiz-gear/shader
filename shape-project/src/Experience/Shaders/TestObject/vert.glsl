#include "/node_modules/lygia/generative/cnoise.glsl"
#include "/node_modules/lygia/math/const.glsl"

uniform float iTime;
uniform vec3 iResolution;
uniform vec4 iMouse;
uniform float uDistort;
uniform float uFrequency;

varying vec2 vUv;
varying float vNoise;
varying vec3 vNormal;
varying vec3 vWorldPosition;


vec3 distort(vec3 p){
    float offset=cnoise(p/uFrequency+iTime*.5);
    float t = (p.y+offset)*PI*12.;
    float noise=(sin(t)*p.x+cos(t)*p.z) * 2.;
    // float noise=sin(p.y*PI*12.);
    noise*=uDistort;
    vNoise=noise;
    p+=noise*normal*.01*uDistort;
    return p;
}

#include "../Common/fixNormal.glsl"

void main(){
    vec3 p=position;
    vec3 dp=distort(p);
    gl_Position=projectionMatrix*modelViewMatrix*vec4(dp,1.);
    
    vUv=uv;
    vNormal=fixNormal(p,dp,normal,RADIUS/SEGMENTS);
    vWorldPosition=(modelMatrix*vec4(p,1.)).xyz;
}