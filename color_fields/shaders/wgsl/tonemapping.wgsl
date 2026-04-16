// shaders/wgsl/tonemapping.wgsl — Tonemapping operators (WGSL port)

fn tonemapReinhard(c: vec3<f32>) -> vec3<f32> { return c / (vec3<f32>(1.0) + c); }
fn tonemapACES(x: vec3<f32>) -> vec3<f32> {
    return clamp((x * (2.51 * x + vec3<f32>(0.03))) / (x * (2.43 * x + vec3<f32>(0.59)) + vec3<f32>(0.14)), vec3<f32>(0.0), vec3<f32>(1.0));
}
fn gammaCorrectSRGB(c: vec3<f32>) -> vec3<f32> { return pow(c, vec3<f32>(0.4545)); }
fn applyExposure(c: vec3<f32>, ev: f32) -> vec3<f32> { return c * pow(2.0, ev); }
