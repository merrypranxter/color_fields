// shaders/wgsl/gradients.wgsl — Gradient and palette functions (WGSL port)

fn cosinePalette(t: f32, a: vec3<f32>, b: vec3<f32>, c: vec3<f32>, d: vec3<f32>) -> vec3<f32> {
    return a + b * cos(6.2831853 * (c * t + d));
}
fn blackBodyGradient(t_in: f32) -> vec3<f32> {
    let t = clamp(t_in, 0.0, 1.0);
    var c: vec3<f32>;
    c.r = smoothstep(0.0, 0.33, t);
    c.g = smoothstep(0.15, 0.6, t) * 0.85;
    c.b = smoothstep(0.4, 0.9, t) * 0.6;
    return c * (0.5 + 2.0 * t * t);
}
