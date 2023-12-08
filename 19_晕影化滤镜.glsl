#iChannel0 "https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
  vec2 uv = fragCoord.xy / iResolution.xy;

  vec2 p = uv;
   p -= .5;
  float d = length(p);
  d = smoothstep(.4, .8, d);
  d = 1.0 - d; // 反转

  vec4 texture = texture(iChannel0, uv);
  texture *= d ;

  fragColor = vec4(texture);
}