# Architecture

## Design Philosophy

`color_fields` is the **aesthetic layer** of the RepoScripter pack ecosystem. While `noise_fields` generates patterns and `sdf_fields` defines geometry, `color_fields` makes them look beautiful (or terrifying, or alien, or cosmic — your call).

## The Color Pipeline

```
Raw value (noise, distance, normal, AO)
  ↓
Remap to [0, 1] range
  ↓
Feed into gradient function (cosine palette, black body, multi-stop)
  ↓
Apply in perceptual space (Oklab) for smooth results
  ↓
Accumulate lighting (multiply albedo × diffuse, add specular)
  ↓
Tonemap HDR → LDR (ACES, Reinhard, etc.)
  ↓
Gamma correct → display
```

## Why Oklab Matters

Most shader tutorials use HSB for color work. HSB is intuitive but **not perceptually uniform** — a gradient from blue to yellow through HSB looks uneven because our eyes perceive yellow as much brighter than blue.

Oklab solves this. Equal steps in Oklab L/a/b correspond to equal perceived color differences. `mixOklab(color1, color2, t)` always produces smooth, natural-looking gradients.

For hue rotation (rainbow effects), use Oklch — the cylindrical form of Oklab — which lets you sweep hue at constant perceived lightness and saturation.

## Companion Packs

- **noise_fields**: Generates the raw values that get color-mapped
- **sdf_fields**: Provides the geometry, normals, AO, and distances that drive coloring decisions
