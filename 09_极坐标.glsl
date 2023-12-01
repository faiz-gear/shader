/* ----------------------------------- 极坐标 ---------------------------------- */
// void mainImage(out vec4 fragColor,  in vec2 fragCoord) {
//   vec2 uv = fragCoord.xy / iResolution.xy;
//   uv = uv * 2.0 - 1.0;
//   uv.x *= iResolution.x / iResolution.y;
//   float r = length(uv); // 半径
//   float rad = atan(uv.y, uv.x); // 极角(弧度) 极坐标轴向右
//   uv = vec2(rad, r);
//   fragColor  = vec4(uv, 0.0, 1.0);
// }

/* ----------------------------------- 放射形 ---------------------------------- */
// void mainImage(out vec4 fragColor,  in vec2 fragCoord) {
//   vec2 uv = fragCoord.xy / iResolution.xy;
//   uv = uv * 2.0 - 1.0;
//   uv.x *= iResolution.x / iResolution.y;
//   float r = length(uv); // 半径
//   float rad = atan(uv.y, uv.x); // 极角(弧度) 极坐标轴向右
//   uv = vec2(rad, r);

//   float c = sin(uv.x * 20.0);

//   fragColor  = vec4(vec3(c), 1.0);
// }

/* ----------------------------------- 螺旋形 ---------------------------------- */
void mainImage(out vec4 fragColor,  in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;
  uv = uv * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;
  float r = length(uv); // 半径
  float rad = atan(uv.y, uv.x); // 极角(弧度) 极坐标轴向右
  uv = vec2(rad, r);

  float c = sin(uv.y * 30.0 + uv.x);

  fragColor  = vec4(vec3(c), 1.0);
}