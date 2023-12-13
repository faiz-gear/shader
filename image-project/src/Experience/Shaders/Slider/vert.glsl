#include "/node_modules/lygia/math/const.glsl"

uniform float iTime;
uniform vec3 iResolution;
uniform vec4 iMouse;
uniform float uVelocity;
uniform float uDistortX;
uniform float uDistortZ;
uniform float uProgress;
uniform vec2 uMeshSize; // 图片网格的大小
uniform vec2 uMeshPosition; // 图片网格的位置



varying vec2 vUv;

// 扭曲
vec3 distort(vec3 p){
  p.x += sin(uv.y*PI)*uVelocity*uDistortX;
  // p.y+=cos((p.x / iResolution.y)*PI)*100.;
  p.z+=cos((p.x / iResolution.y)*PI)*abs(uVelocity)*uDistortZ;
  return p;
}

// 交错
float getStagger(vec2 uv){
    float left=uv.x;
    float bottom=uv.y;
    float right=1.-uv.x;
    float top=1.-uv.y;
    return top*right;
}

// 过渡
vec3 transition(vec3 p){
  float pr=uProgress;

  float stagger=getStagger(uv);
  pr=smoothstep(stagger*0.8,1.,pr);

  vec2 targetScale=iResolution.xy/uMeshSize;
  vec2 scale = mix(vec2(1.), targetScale, pr);
  p.xy*=scale;

  p.xy+=-uMeshPosition*pr; // 处理点击不在中间的图片
  p.z+=pr; // 解决图片重叠深度冲突
  return p;
}



void main(){
    vec3 p=position;
    p=transition(p);
    vec4 mvPosition=modelViewMatrix*vec4(p,1.);
    mvPosition.xyz=distort(mvPosition.xyz);
    gl_Position=projectionMatrix*mvPosition;

    vUv=uv;
}
