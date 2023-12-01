float sdBox( in vec2 p, in vec2 b )
{
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

// 圆角
float opRound( in float d, in float r )
{
  return d - r;
}

// 镂空
float opOnion( in float d, in float r )
{
  return abs(d) - r;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;
  uv  = uv * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;

  float d = sdBox(uv, vec2(0.6, 0.3));
  // d = opRound(d, 0.1);
  d = opOnion(d, 0.1);
  d = smoothstep(0.0, 0.02, d);

  fragColor = vec4(vec3(d), 1.0);
}