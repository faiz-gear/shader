
// 3D球体sdf函数
float sdSphere(vec3 p,float r)
{
    return length(p)-r;
}

// 3D平面sdf函数
float sdPlane( vec3 p, vec3 n, float h )
{
  // n must be normalized
  return dot(p,n) + h;
}


// 顺滑交集
float opSmoothUnion( float d1, float d2, float k )
{
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h);
}

// 并集
float opUnion(float d1,float d2)
{
    return min(d1,d2);
}

// 二维并集
vec2 opUnion(vec2 d1,vec2 d2)
{
    return(d1.x<d2.x)?d1:d2;
}

vec2 map(vec3 p){
    vec2 d=vec2(1e10,0.);

  // 计算给点到中心点为(0.,0.,-2.)、半径为1.的球体的距离
    float d1=sdSphere(p-vec3(0.,0.,-2.),1.);

    // 计算小球体的符号距离
    float d2 = sdSphere(p - vec3(0., 1. + abs(sin(iTime)), -2.), .5); 
    d1 = opSmoothUnion(d1, d2, .5);

    d = opUnion(d, vec2(d1, 1.)); // 球形设置材质

    // 计算平面的符号距离
    float d3=sdPlane(p-vec3(0.,-1.,0.),vec3(0.,1.,0.),.1);
    d = opUnion(d, vec2(d3, 2.)); // 平面设置材质

    return d;
}

// 计算法线
vec3 calcNormal(in vec3 p)
{
    const float h=.0001;
    const vec2 k=vec2(1,-1);
    return normalize(k.xyy*map(p+k.xyy*h).x+
    k.yyx*map(p+k.yyx*h).x+
    k.yxy*map(p+k.yxy*h).x+
    k.xxx*map(p+k.xxx*h).x);
}

// soft阴影
float softshadow(in vec3 ro,in vec3 rd,float mint,float maxt,float k)
{
    float res=1.;
    float t=mint;
    for(int i=0;i<256&&t<maxt;i++)
    {
        float h=map(ro+rd*t).x;
        if(h<.001)
        return 0.;
        res=min(res,k*h/t);
        t+=h;
    }
    return res;
}

vec3 getSceneColor(vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;
  uv = uv * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;

  vec3 ro=vec3(0.,0.,1.); // 1.创建光线（相机位置）

  vec3 rd=normalize(vec3(uv,0.)-ro); // 光线方向

  vec3 col=vec3(0.); // 输出颜色默认黑色

  float depth=0.; // 行进距离
  for(int i=0;i<128;i++){
      vec3 p=ro+rd*depth; // 计算当前位置
      vec2 res=map(p);

      float d=res.x; // x维度是形状
      float m=res.y; // y维度是材质
      // float d=map(p); // 计算当前符号距离

      depth+=d; // 行进距离增加
      if(d<.01){
        // 如果距离无限趋近于0，说明已经碰撞到物体，给物体添加颜色, 跳出循环
          // col=vec3(1.);
          vec3 normal=calcNormal(p);

          vec3 objectColor=vec3(1.);
          vec3 lightColor=vec3(.875,.286,.333);

          // material
          if(m==2.){
              lightColor=vec3(1.);
          }

          // 添加光照
          // ambient
          float ambIntensity=.2;
          vec3 ambient=lightColor*ambIntensity;
          col+=ambient*objectColor;

          // diffuse
          vec3 lightPos=vec3(10.,10.,10.);
          vec3 lightDir=normalize(lightPos-p);
          float diff=dot(normal,lightDir);
          diff=max(diff,0.);
          vec3 diffuse=lightColor*diff;
          float shadow=softshadow(p,lightDir,.01,10.,16.);
            col+=diffuse*objectColor*shadow;
            

          // specular
          vec3 reflectDir=reflect(-lightDir,normal);
          vec3 viewDir=normalize(ro-p);
          vec3 halfVec=normalize(lightDir+viewDir);
          float spec=dot(normal,halfVec);
          spec=max(spec,0.);
          float shininess=32.;
          spec=pow(spec,shininess);
          vec3 specular=lightColor*spec;
          col+=specular*objectColor;
          break;
      }
  }

  return col;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
  vec3 totalColor = vec3(0.0);
  totalColor += getSceneColor(fragCoord);

/* ----------------------------------- 抗锯齿 ---------------------------------- */
// 将场景进行多次渲染，并且每次渲染要偏移UV坐标
  float AA_size=2.; // 越大效果越好
  float count=0.;
  for(float aaY=0.;aaY<AA_size;aaY++)
  {
      for(float aaX=0.;aaX<AA_size;aaX++)
      {
          // 多次采样平均化让多个样本点的颜色混合在一起
          totalColor+=getSceneColor(fragCoord+vec2(aaX,aaY)/AA_size);
          count+=1.;
      }
  }
  totalColor/=count;
/* ----------------------------------- 抗锯齿 ---------------------------------- */



  fragColor=vec4(totalColor, 1.);
}
