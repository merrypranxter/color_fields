// shaders/glsl/tonemapping.glsl
// HDR to LDR tonemapping operators.

#ifndef COLOR_FIELDS_TONEMAPPING_GLSL
#define COLOR_FIELDS_TONEMAPPING_GLSL

// === Reinhard ===
vec3 tonemapReinhard(vec3 c) { return c / (1.0 + c); }

// === ACES Filmic (fitted) ===
vec3 tonemapACES(vec3 x) {
    float a = 2.51;
    float b = 0.03;
    float c = 2.43;
    float d = 0.59;
    float e = 0.14;
    return clamp((x * (a * x + b)) / (x * (c * x + d) + e), 0.0, 1.0);
}

// === Uncharted 2 / Hable Filmic ===
vec3 _hablePartial(vec3 x) {
    float A = 0.15, B = 0.50, C = 0.10, D = 0.20, E = 0.02, F = 0.30;
    return ((x * (A * x + C * B) + D * E) / (x * (A * x + B) + D * F)) - E / F;
}
vec3 tonemapUncharted2(vec3 c) {
    float exposureBias = 2.0;
    vec3 curr = _hablePartial(c * exposureBias);
    vec3 whiteScale = 1.0 / _hablePartial(vec3(11.2));
    return curr * whiteScale;
}

// === AgX (simplified approximation) ===
vec3 tonemapAgX(vec3 c) {
    // Simplified AgX-like curve
    vec3 x = max(vec3(0.0), c);
    vec3 a = x * (x + 0.0245786) - 0.000090537;
    vec3 b = x * (0.983729 * x + 0.4329510) + 0.238081;
    return a / b;
}

// === Gamma correction (final step) ===
vec3 gammaCorrect(vec3 c, float gamma) { return pow(c, vec3(1.0 / gamma)); }
vec3 gammaCorrectSRGB(vec3 c) { return pow(c, vec3(0.4545)); }

// === Exposure ===
vec3 applyExposure(vec3 c, float ev) { return c * pow(2.0, ev); }

// === Contrast (S-curve) ===
vec3 applyContrast(vec3 c, float amount) {
    return clamp(mix(vec3(0.5), c, amount), 0.0, 1.0);
}

// === Vignette ===
float vignette(vec2 uv, float strength, float radius) {
    float d = length(uv - 0.5) * 2.0;
    return 1.0 - smoothstep(radius, radius + strength, d);
}

#endif
