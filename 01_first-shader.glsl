void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec3 color1 = vec3(0.8667, 0.502, 0.1137);
  vec3 color2 = vec3(0.1137, 0.8667, 0.4157);
  vec3 color3 = vec3(0.7176, 0.7412, 0.7412);
  vec3 color4 = vec3(0.1137, 0.1882, 0.8667);
  if(fragCoord.x < iResolution.x * 0.25) {
    fragColor = vec4(color1, 1.0);
  } else if (fragCoord.x < iResolution.x * 0.5) {
     fragColor = vec4(color2, 1.0);
  } else if (fragCoord.x < iResolution.x * 0.75) {
     fragColor = vec4(color3, 1.0);
  } else if (fragCoord.x < iResolution.x * 1.0) {
     fragColor = vec4(color4, 1.0);
  }
}