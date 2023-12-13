#include "/node_modules/lygia/color/palette.glsl"

uniform float iTime;
uniform vec3 iResolution;
uniform vec4 iMouse;

varying vec2 vUv;
varying float vNoise;
varying vec3 vNormal;
varying vec3 vWorldPosition;


void main(){
    vec2 uv=vUv;
    vec3 col=vec3(1.);
    col=palette(vNoise,vec3(0.8, 0.5, 0.4),vec3(0.2, 0.4, 0.2),vec3(2.0, 1.0, 1.0),vec3(0.00, 0.25, 0.25));
    gl_FragColor=vec4(col,1.);
}