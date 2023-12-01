// void mainImage(out vec4 fragColor, in vec2 fragCoord) {
//   vec2 uv = fragCoord / iResolution.xy;
//   uv = uv * 2.0 - 1.0;
//   uv.x *= iResolution.x / iResolution.y;
//   vec3 color1 = vec3(1, 0, 0);
//   vec3 color2 = vec3(0, 1, 0);
//   vec3 finalColor = mix(color1, color2, uv.x); // 渐变色
//   fragColor = vec4(finalColor, 1.0);
// }

float sdBox( in vec2 p, in vec2 b )
{
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

// 符号距离函数-圆
float sdCircle(vec2 uv, float radius) {
  return length(uv) - radius;
}


/* -------------------------------- sdf图形添加颜色 ------------------------------- */
// void mainImage(out vec4 fragColor, in vec2 fragCoord) {
//   vec2 uv = fragCoord / iResolution.xy;
//   uv = uv * 2.0 - 1.0;
//   uv.x *= iResolution.x / iResolution.y;
//   float d = sdBox(uv, vec2(0.25, 0.25));
//   d = smoothstep(0.0,0.01, d);
//   vec3 innerColor = vec3(1, 0, 0);
//   vec3 outerColor = vec3(1, 1, 1);
//   vec3 finalColor = mix(innerColor, outerColor, d); // 渐变色
//   fragColor = vec4(finalColor, 1.0);
// }

/* --------------------------------- 形状转变效果 --------------------------------- */
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  uv = uv * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;
  float dBox = sdBox(uv, vec2(0.25, 0.25));
  float dCircle = sdCircle(uv, 0.3);
  float d = mix(dBox, dCircle, abs(sin(iTime)));
  d = smoothstep(0.0,0.01, d);
  vec3 finalColor = vec3(d); // 渐变色
  fragColor = vec4(finalColor, 1.0);
}