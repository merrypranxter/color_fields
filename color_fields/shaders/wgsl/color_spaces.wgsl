// shaders/wgsl/color_spaces.wgsl — Color space conversions (WGSL port)

fn rgb2hsb(c: vec3<f32>) -> vec3<f32> {
    let K = vec4<f32>(0.0, -1.0/3.0, 2.0/3.0, -1.0);
    let p = mix(vec4<f32>(c.b, c.g, K.w, K.z), vec4<f32>(c.g, c.b, K.x, K.y), vec4<f32>(step(c.b, c.g)));
    let q = mix(vec4<f32>(p.x, p.y, p.w, c.r), vec4<f32>(c.r, p.y, p.z, p.x), vec4<f32>(step(p.x, c.r)));
    let d = q.x - min(q.w, q.y);
    let e = 1.0e-10;
    return vec3<f32>(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

fn hsb2rgb(c: vec3<f32>) -> vec3<f32> {
    var rgb = clamp(abs(((c.x * 6.0 + vec3<f32>(0.0, 4.0, 2.0)) % vec3<f32>(6.0)) - vec3<f32>(3.0)) - vec3<f32>(1.0), vec3<f32>(0.0), vec3<f32>(1.0));
    rgb = rgb * rgb * (vec3<f32>(3.0) - 2.0 * rgb);
    return c.z * mix(vec3<f32>(1.0), rgb, vec3<f32>(c.y));
}

fn srgb2linear(c: vec3<f32>) -> vec3<f32> {
    return mix(c / 12.92, pow((c + vec3<f32>(0.055)) / 1.055, vec3<f32>(2.4)), step(vec3<f32>(0.04045), c));
}
fn linear2srgb(c: vec3<f32>) -> vec3<f32> {
    return mix(c * 12.92, 1.055 * pow(c, vec3<f32>(1.0/2.4)) - vec3<f32>(0.055), step(vec3<f32>(0.0031308), c));
}

fn linear2oklab(c: vec3<f32>) -> vec3<f32> {
    let l = 0.4122214708 * c.r + 0.5363325363 * c.g + 0.0514459929 * c.b;
    let m = 0.2119034982 * c.r + 0.6806995451 * c.g + 0.1073969566 * c.b;
    let s = 0.0883024619 * c.r + 0.2817188376 * c.g + 0.6299787005 * c.b;
    let l_ = pow(l, 1.0/3.0); let m_ = pow(m, 1.0/3.0); let s_ = pow(s, 1.0/3.0);
    return vec3<f32>(0.2104542553*l_ + 0.7936177850*m_ - 0.0040720468*s_, 1.9779984951*l_ - 2.4285922050*m_ + 0.4505937099*s_, 0.0259040371*l_ + 0.7827717662*m_ - 0.8086757660*s_);
}
fn oklab2linear(c: vec3<f32>) -> vec3<f32> {
    let l_ = c.x + 0.3963377774*c.y + 0.2158037573*c.z;
    let m_ = c.x - 0.1055613458*c.y - 0.0638541728*c.z;
    let s_ = c.x - 0.0894841775*c.y - 1.2914855480*c.z;
    return vec3<f32>(4.0767416621*l_*l_*l_ - 3.3077115913*m_*m_*m_ + 0.2309699292*s_*s_*s_, -1.2684380046*l_*l_*l_ + 2.6097574011*m_*m_*m_ - 0.3413193965*s_*s_*s_, -0.0041960863*l_*l_*l_ - 0.7034186147*m_*m_*m_ + 1.7076147010*s_*s_*s_);
}
fn srgb2oklab(c: vec3<f32>) -> vec3<f32> { return linear2oklab(srgb2linear(c)); }
fn oklab2srgb(c: vec3<f32>) -> vec3<f32> { return linear2srgb(oklab2linear(c)); }

fn mixOklab(rgb1: vec3<f32>, rgb2: vec3<f32>, t: f32) -> vec3<f32> {
    return oklab2srgb(mix(srgb2oklab(rgb1), srgb2oklab(rgb2), vec3<f32>(t)));
}
