// examples/palette_explorer.glsl
// ShaderToy: Cosine palette explorer — 5 presets shown as noise-driven bands.
// Paste into shadertoy.com as Image shader.

vec3 pal(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
    return a + b * cos(6.2831853 * (c * t + d));
}

// Simplex-ish hash for variation
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}
float noise(vec2 p) {
    vec2 i = floor(p), f = fract(p);
    f = f*f*(3.0-2.0*f);
    return mix(mix(hash(i), hash(i+vec2(1,0)), f.x),
               mix(hash(i+vec2(0,1)), hash(i+vec2(1,1)), f.x), f.y);
}
float fbm(vec2 p) {
    float v = 0.0, a = 0.5;
    for (int i = 0; i < 5; i++) { v += a * noise(p); p *= 2.0; a *= 0.5; }
    return v;
}

void mainImage(out vec4 O, vec2 F) {
    vec2 uv = F / iResolution.xy;
    float t = fbm(uv * 4.0 + iTime * 0.2);

    // 5 horizontal bands, one per palette
    int band = int(uv.y * 5.0);
    vec3 col;
    if (band == 0) col = pal(t, vec3(0.5), vec3(0.5), vec3(1.0), vec3(0.0,0.33,0.67));           // Sunset
    else if (band == 1) col = pal(t, vec3(0.5), vec3(0.5), vec3(1.0,1.0,0.5), vec3(0.0,0.1,0.2)); // Fire
    else if (band == 2) col = pal(t, vec3(0.5), vec3(0.5), vec3(1.0,0.7,0.4), vec3(0.0,0.15,0.2));// Ocean
    else if (band == 3) col = pal(t, vec3(0.5), vec3(0.5,0.5,0.33), vec3(2.0,1.0,1.0), vec3(0.5,0.2,0.25)); // Neon
    else col = pal(t, vec3(0.8), vec3(0.2), vec3(1.0), vec3(0.0,0.33,0.67));                       // Pastel

    // Thin separator lines
    float bandY = fract(uv.y * 5.0);
    if (bandY < 0.01 || bandY > 0.99) col *= 0.3;

    O = vec4(col, 1.0);
}
