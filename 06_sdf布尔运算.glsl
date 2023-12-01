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

/* ----------------------------------- 平滑版 ---------------------------------- */
float opSmoothUnion( float d1, float d2, float k )
{
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h);
}

float opSmoothSubtraction( float d1, float d2, float k )
{
    float h = clamp( 0.5 - 0.5*(d2+d1)/k, 0.0, 1.0 );
    return mix( d2, -d1, h ) + k*h*(1.0-h);
}

float opSmoothIntersection( float d1, float d2, float k )
{
    float h = clamp( 0.5 - 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) + k*h*(1.0-h);
}
/* ----------------------------------- 平滑版 ---------------------------------- */


void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    uv=(uv-.5)*2.;
    uv.x*=iResolution.x/iResolution.y;

    float d1=sdCircle(uv,.5);
    float d2=sdBox(uv,vec2(.6,.3));

    // float d=opUnion(d1, d2); // 并集
    // float d=opIntersection(d1, d2); // 交集
    // float d=opSubtraction(d1, d2); // 差
    // float d=opSubtraction(d2, d1); // 差
    
    // float d = opSmoothUnion(d1, d2, 0.05); // 平滑版并集
    // float d = opSmoothIntersection(d1, d2, 0.05); // 平滑版交集
    // float d = opSmoothSubtraction(d1, d2, 0.05); // 平滑版差集
    float d = opSmoothSubtraction(d2, d1, 0.1); // 平滑版差集

    float c=smoothstep(0.,.005,d);
    fragColor=vec4(vec3(c),1.);
}