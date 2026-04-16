// shaders/glsl/gradients.glsl
// Gradient and palette generation functions.

#ifndef COLOR_FIELDS_GRADIENTS_GLSL
#define COLOR_FIELDS_GRADIENTS_GLSL

// === IQ Cosine Palette ===
// The most versatile single-line palette generator in shader art.
// color(t) = a + b * cos(2π(c*t + d))
// See: iquilezles.org/articles/palettes

vec3 cosinePalette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
    return a + b * cos(6.2831853 * (c * t + d));
}

// Named presets
vec3 cosinePaletteSunset(float t) { return cosinePalette(t, vec3(0.5), vec3(0.5), vec3(1.0), vec3(0.0, 0.33, 0.67)); }
vec3 cosinePaletteFire(float t)   { return cosinePalette(t, vec3(0.5), vec3(0.5), vec3(1.0, 1.0, 0.5), vec3(0.0, 0.1, 0.2)); }
vec3 cosinePaletteOcean(float t)  { return cosinePalette(t, vec3(0.5), vec3(0.5), vec3(1.0, 0.7, 0.4), vec3(0.0, 0.15, 0.2)); }
vec3 cosinePaletteNeon(float t)   { return cosinePalette(t, vec3(0.5), vec3(0.5, 0.5, 0.33), vec3(2.0, 1.0, 1.0), vec3(0.5, 0.2, 0.25)); }
vec3 cosinePalettePastel(float t) { return cosinePalette(t, vec3(0.8), vec3(0.2), vec3(1.0), vec3(0.0, 0.33, 0.67)); }

// === Black Body Radiation ===
// Attempt to approximate the color of a blackbody at temperature T (normalized 0-1)

vec3 blackBodyGradient(float t) {
    t = clamp(t, 0.0, 1.0);
    vec3 c;
    c.r = smoothstep(0.0, 0.33, t);
    c.g = smoothstep(0.15, 0.6, t) * 0.85;
    c.b = smoothstep(0.4, 0.9, t) * 0.6;
    // Boost intensity for hot values
    c *= 0.5 + 2.0 * t * t;
    return c;
}

// === Spectral Rainbow (Oklch-based, perceptually smooth) ===

vec3 spectralRainbow(float t) {
    // Sweep hue in Oklch at constant L and C
    float L = 0.7;
    float C = 0.15;
    float h = t * 6.2831853; // Full hue rotation
    vec3 lch = vec3(L, C, h);
    vec3 lab = vec3(lch.x, lch.y * cos(lch.z), lch.y * sin(lch.z));
    // Inline oklab2linear to avoid dependency
    float l_ = lab.x + 0.3963377774 * lab.y + 0.2158037573 * lab.z;
    float m_ = lab.x - 0.1055613458 * lab.y - 0.0638541728 * lab.z;
    float s_ = lab.x - 0.0894841775 * lab.y - 1.2914855480 * lab.z;
    float l = l_ * l_ * l_;
    float m = m_ * m_ * m_;
    float s = s_ * s_ * s_;
    vec3 rgb = vec3(
         4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
        -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
        -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s
    );
    return clamp(rgb, 0.0, 1.0);
}

// === Multi-stop gradient (up to 8 colors) ===
// colors[] and positions[] must be sorted by position ascending.

vec3 gradientLerp(float t, vec3 c0, vec3 c1, vec3 c2, vec3 c3, vec3 c4) {
    t = clamp(t, 0.0, 1.0) * 4.0;
    if (t < 1.0) return mix(c0, c1, t);
    if (t < 2.0) return mix(c1, c2, t - 1.0);
    if (t < 3.0) return mix(c2, c3, t - 2.0);
    return mix(c3, c4, t - 3.0);
}

#endif
