#iChannel0 "https://s2.loli.net/2023/12/01/EcjLJDsGA3IXFMV.png"
#iChannel1 "https://s2.loli.net/2023/09/10/Jb8mIhZMBElPiuC.jpg"
#iChannel2 "https://s2.loli.net/2023/07/17/3GDlwcvehqQjTPH.jpg"
#iChannel3 "https://s2.loli.net/2023/12/01/aUQxzIR3DnT4WY2.jpg"
#iChannel4 "https://s2.loli.net/2023/12/01/C84vTiH23eJFNEn.png"

// 符号距离函数-圆
float sdCircle(vec2 uv, float radius) {
  return length(uv) - radius;
}

// 符号距离函数-矩形
float sdBox( in vec2 p, in vec2 b )
{
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}


/* ----------------------------------- 采样 ----------------------------------- */
// void mainImage(out vec4 fragColor,in vec2 fragCoord){
//     vec2 uv=fragCoord/iResolution.xy;
//     // fragColor=vec4(uv.x,0.,0.,1.);
//     // fragColor=vec4(0.,uv.y,0.,1.);
//     vec3 tex = texture(iChannel0,uv).rgb;
//     fragColor=vec4(tex,1.);
// }




/* ----------------------------------- 扭曲 ----------------------------------- */
// vec2 distort(vec2 p) {
//   p.x += sin(p.y*10. + iTime) / 50.0;
//   return p;
// }

// void mainImage(out vec4 fragColor,in vec2 fragCoord){
//     vec2 uv=fragCoord/iResolution.xy;
//     uv = distort(uv);
//     // fragColor=vec4(uv.x,0.,0.,1.);
//     // fragColor=vec4(0.,uv.y,0.,1.);
//     vec4 tex = texture(iChannel0,uv);
//     fragColor=vec4(tex);
// }


// 获取纹理0
vec4 getFromColor(vec2 uv) {
  return texture(iChannel0, uv);
}

// 获取纹理1
vec4 getToColor(vec2 uv) {
  return texture(iChannel1, uv);
}
/* ----------------------------------- 滑动转场 ----------------------------------- */
// 根据鼠标x位置过渡
// vec4 transition(vec2 uv) {
//   float progress = iMouse.x / iResolution.x;
  
//   return mix(getFromColor(uv), getToColor(uv), 1.-step(progress, uv.x));
// }


// void mainImage(out vec4 fragColor,in vec2 fragCoord){
//     vec2 uv=fragCoord/iResolution.xy;
//     // fragColor=vec4(uv.x,0.,0.,1.);
//     // fragColor=vec4(0.,uv.y,0.,1.);
//     vec4 tex = transition(uv);
//     fragColor=vec4(tex);
// }


/* ----------------------------------- 遮罩转场 ----------------------------------- */
// 根据鼠标x位置过渡
// vec4 transition(vec2 uv) {
//   float progress = iMouse.x / iResolution.x;
//   float ratio = iResolution.x / iResolution.y;
//   vec2 p = uv;
//   p -= 0.5;
//   p.x *= ratio;

//   float d = sdCircle(p, progress);
//   float c = smoothstep(-0.2, 0., d);
  
//   return mix(getFromColor(uv), getToColor(uv), 1.-c);
// }


// void mainImage(out vec4 fragColor,in vec2 fragCoord){
//     vec2 uv=fragCoord/iResolution.xy;
//     // fragColor=vec4(uv.x,0.,0.,1.);
//     // fragColor=vec4(0.,uv.y,0.,1.);
//     vec4 tex = transition(uv);
//     fragColor=vec4(tex);
// }

/* ----------------------------------- 置换转场 ----------------------------------- */
// 根据鼠标x位置过渡
vec4 transition(vec2 uv) {
  float progress = iMouse.x / iResolution.x;
  float ratio = iResolution.x / iResolution.y;

  vec2 dis = texture(iChannel4, uv).xy;
  vec2 uv0 = vec2(uv.x - dis.x * progress, uv.y);
  vec2 uv1 = vec2(uv.x + dis.x * (1. - progress), uv.y);

  
  return mix(getFromColor(uv0), getToColor(uv1), progress);
}


void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    // fragColor=vec4(uv.x,0.,0.,1.);
    // fragColor=vec4(0.,uv.y,0.,1.);
    vec4 tex = transition(uv);
    fragColor=vec4(tex);
}