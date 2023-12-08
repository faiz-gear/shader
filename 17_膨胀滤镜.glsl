#iChannel0 "https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"

// 膨胀函数bulge
vec2 bulge(vec2 p) {
  // vec2 center = vec2(.5); // 中心点
  vec2 center=iMouse.xy/iResolution.xy;

  float radius=.9;
  float strength=1.1;

  p -= center; // 原点居中后计算距离
  float d = length(p);
  // p*=d; // 向外膨胀
  // p *= pow(d, 2.); // 更强烈的向外膨胀
  // p *= 1. / (pow(d, 2.) + 1.); // 向内膨胀

  d/=radius;
  float dPow=pow(d,2.);
  float dRev=strength / (dPow+1.);
  p *= dRev;

  p += center; // 加回去
  return p;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
  // 根据鼠标位置膨胀指定点
  vec2 uv = fragCoord.xy / iResolution.xy;
  uv = bulge(uv);
  vec3 tex=texture(iChannel0,uv).xyz;
  fragColor=vec4(tex,1.);
}