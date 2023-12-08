#iChannel0 "https://s2.loli.net/2023/09/10/63quVIA9xZLksDc.jpg"

highp float random(vec2 co)
{
    highp float a=12.9898;
    highp float b=78.233;
    highp float c=43758.5453;
    highp float dt=dot(co.xy,vec2(a,b));
    highp float sn=mod(dt,3.14);
    return fract(sin(sn)*c);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 rUv = uv;
    vec2 gUv = uv;
    vec2 bUv = uv;
    float noise = random(uv) * 0.5 + 0.5;
    vec2 offset = 0.001 * vec2(cos(noise), sin(noise));
    rUv += offset;
    gUv -= offset;

    vec4 rTexture = texture(iChannel0, rUv);
    vec4 gTexture = texture(iChannel0, gUv);
    vec4 bTexture = texture(iChannel0, bUv);

    fragColor = vec4(rTexture.r, gTexture.g,bTexture.b,1.0);
}