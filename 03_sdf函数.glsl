// 常用sdf函数网站: https://iquilezles.org/articles/distfunctions2d/
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


void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;
  uv = uv * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;
  // float d = sdCircle(uv, 0.5);
  float d = sdBox(uv, vec2(0.6, 0.3));
  d = smoothstep(0.0, 0.02, d);
  vec3 color = vec3(d);
  fragColor = vec4(color, 1.0);
}