
// 符号距离函数-矩形
float sdBox( in vec2 p, in vec2 b )
{
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

// 符号距离函数-等边三角形
float sdEquilateralTriangle(in vec2 p,in float r)
{
    const float k=sqrt(3.);
    p.x=abs(p.x)-r;
    p.y=p.y+r/k;
    if(p.x+k*p.y>0.)p=vec2(p.x-k*p.y,-k*p.x-p.y)/2.;
    p.x-=clamp(p.x,-2.*r,0.);
    return-length(p)*sign(p.y);
}

mat2 rotation2d(float angle){
    float s=sin(angle);
    float c=cos(angle);

    return mat2(
        c,-s,
        s,c
    );
}

// 旋转
vec2 rotate(vec2 v,float angle){
    return rotation2d(angle)*v;
}




const float PI=3.14159265359;

// void mainImage(out vec4 fragColor, in vec2 fragCoord) {
//   vec2 uv = fragCoord / iResolution.xy;
//   uv = uv * 2.0 - 1.0; // uv原点居中
//   uv.x *= iResolution.x / iResolution.y;

//   // uv平移: 根据原点的位置判断当前平移的方向
//   // uv.x += 0.1; // 原点在左边， 向左
//   uv.x -= 0.1; // 原点在右边， 向右
//   // uv.y += 0.1; // 原点在下边，向下
//   uv.y -= 0.1; // 原点在上边，向上

//   // uv缩放
//   // uv *= 2.0; // 缩小
//   // uv /= 2.0; // 放大

//   // uv旋转
//   // uv *= -1.0; // x轴翻转
//   uv = rotate(uv, PI * iTime);

//   // float d = sdBox(uv, vec2(0.2));
//   float d = sdEquilateralTriangle(uv, 0.2);
//   d = smoothstep(0.0, 0.005, d);

//   fragColor = vec4(vec3(d), 1.0);
// }


// void mainImage(out vec4 fragColor, in vec2 fragCoord) {
//   vec2 uv = fragCoord / iResolution.xy;
//   // 重复： 只取小数位，不要整数位
//   uv = fract(uv * 2.0);
//   uv -= 0.5;
//   uv.x *= iResolution.x / iResolution.y;
//   float d = sdEquilateralTriangle(uv, 0.2);
//   d = smoothstep(0.0, 0.005, d);

//   fragColor = vec4(vec3(d), 1.0);
// }

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  // 镜像
  uv = uv * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;
  uv.y = abs(uv.y);

  float d = sdEquilateralTriangle(uv, 0.2);
  d = smoothstep(0.0, 0.005, d);

  fragColor = vec4(vec3(d), 1.0);
}