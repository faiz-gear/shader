#include "/node_modules/lygia/color/palette.glsl"
#include "/node_modules/lygia/lighting/fresnel.glsl"

uniform float iTime;
uniform vec3 iResolution;
uniform vec4 iMouse;
uniform vec3 uThemeColor;
uniform vec3 uLightColor;
uniform vec3 uLightColor2;

varying vec2 vUv;
varying float vNoise;
varying vec3 vNormal;
varying vec3 vWorldPosition;


void main(){
    vec2 uv=vUv;
    vec3 col=vec3(vNoise);
    // col=palette(vNoise,vec3(0.8, 0.5, 0.4),vec3(0.2, 0.4, 0.2),vec3(2.0, 1.0, 1.0),vec3(0.00, 0.25, 0.25));
    vec3 viewDir=normalize(cameraPosition-vWorldPosition); // 眼睛方向向量（就是片元指向摄像头）
    vec3 fres=fresnel(uThemeColor,vNormal,viewDir); // 菲涅尔光照
    col=fres;

    // 漫反射1
    vec3 lightColor=uLightColor;
    vec3 lightPos=vec3(10.,10.,10.);
    vec3 lightDir=normalize(lightPos-vWorldPosition);
    float diff=max(dot(vNormal,lightDir),0.);
    // 菲涅尔反射的妙用--作为透明度和其他颜色结合,会产生一种光泽感
    col=mix(col,lightColor,diff*fres);

    // 漫反射2
    vec3 lightColor2=uLightColor2;
    vec3 lightPos2=vec3(-10.,-10.,10.);
    vec3 lightDir2=normalize(lightPos2-vWorldPosition);
    float diff2=max(dot(vNormal,lightDir2),0.);
    col=mix(col,lightColor2,diff2*fres);
    // col+=diff*lightColor;

    gl_FragColor=vec4(col,1.);
}