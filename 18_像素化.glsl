#iChannel0 "https://s2.loli.net/2023/09/10/QozT59R6KsYmb3q.jpg"

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 size = vec2(50, 50);
    uv.x= floor(uv.x * size.x) / size.x;
    uv.y= floor(uv.y * size.y) / size.y;

    vec4 texture = texture(iChannel0, uv);
    fragColor = vec4(texture.xyz, 1.);
}