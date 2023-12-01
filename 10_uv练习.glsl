void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;
  uv = uv * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;
  float d = step(0.0, uv.y * uv.x);
  fragColor = vec4(vec3(d), 1.0);
}