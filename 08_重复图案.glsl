// 并集
float opUnion(float d1,float d2)
{
    return min(d1,d2);
}

// 交集
float opIntersection(float d1,float d2)
{
    return max(d1,d2);
}

// 差
float opSubtraction(float d1,float d2)
{
    return max(-d1,d2);
}

// 符号距离函数-圆
float sdCircle(vec2 uv, float radius) {
  return length(uv) - radius;
}


/* ----------------------------------- 条纹 ----------------------------------- */
// void mainImage(out vec4 fragColor, in vec2 fragCoord) {
//   vec2 uv = fragCoord / iResolution.xy;
//   uv.x *= iResolution.x / iResolution.y;
//   uv = fract(uv * 16.);
//   // float dx = step(0.5, uv.x); // x方向重复
//   float dy = step(0.5, uv.y); // y方向重复
//   vec3 color = vec3(dy);
//   fragColor = vec4(color, 1.0);
// }

/* ----------------------------------- 波浪 ----------------------------------- */
// void mainImage(out vec4 fragColor, in vec2 fragCoord) {
//   vec2 uv = fragCoord / iResolution.xy;
//   uv.x *= iResolution.x / iResolution.y;
//   uv.x+=sin(uv.y * 6.0) * 0.4;
//   uv = fract(uv * 16.);
//   float dx = step(0.5, uv.x); // x方向重复
//   // float dy = step(0.5, uv.y); // y方向重复
//   vec3 color = vec3(dx);
//   fragColor = vec4(color, 1.0);
// }

/* ----------------------------------- 网格 ----------------------------------- */
// void mainImage(out vec4 fragColor, in vec2 fragCoord) {
//   vec2 uv = fragCoord / iResolution.xy;
//   uv.x *= iResolution.x / iResolution.y;
//   uv = fract(uv * 16.);
//   float dx = step(0.25, uv.x); // x方向重复
//   float dy = step(0.25, uv.y); // y方向重复
//   vec3 color = vec3(opUnion(dx, dy));
//   fragColor = vec4(color, 1.0);
// }

/* ----------------------------------- 波纹 ----------------------------------- */
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  const float PI=3.14159265359;
  vec2 uv = fragCoord / iResolution.xy;
  uv = uv * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;
  float d = sdCircle(uv, 0.5);
  d = sin(d * PI * 20.0);
  d = smoothstep(0.0, 0.005, d);
  vec3 color = vec3(d);
  fragColor = vec4(color, 1.0);
}