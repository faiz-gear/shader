#iChannel0 "https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"

// 染色滤镜
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;
  vec3 col = texture(iChannel0, uv).rgb;
  vec3 addColor = vec3(0.6353, 0.2549, 0.2549);
  col *= addColor;
  fragColor = vec4(col, 1.0);
}