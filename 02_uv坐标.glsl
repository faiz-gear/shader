void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  // 1.uv
  // vec2 uv = fragCoord.xy / iResolution.xy;
  // uv = (uv - 0.5) * 2.0;
  // vec3 col = vec3(uv, 0.0);
  // fragColor = vec4(col, 1.0);

  // 2.绘制圆形
  // 2.1模糊效果
//   vec2 uv = fragCoord.xy / iResolution.xy;
//   uv = (uv - 0.5) * 2.0;
//   uv.x*=iResolution.x/iResolution.y;
//   float len = length(uv);
//   len -= 0.5;
//   // len = step(0.0, len); // 阶梯函数优化if判断
//   /** 
// smoothstep:小于edge1取0， 大于的edge2取1， 在edge1和edge2之间的取值返回0-1的平滑过渡值
// 优化锯齿
//   */
//   len = smoothstep(0.0, 0.02, len); 
//   vec3 col = vec3(len);
//   fragColor = vec4(col, 1.0);

  // 2.2发光效果
  vec2 uv = fragCoord.xy / iResolution.xy;
  uv = (uv - 0.5) * 2.0;
  uv.x*=iResolution.x/iResolution.y;
  float len = length(uv);
  vec3 col = vec3(pow(0.2 / len, 3.6));
  fragColor = vec4(col, 1.0);
}