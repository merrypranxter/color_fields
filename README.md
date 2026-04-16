# color_fields

**Color Science & Palette Pack for [RepoScripter](https://github.com/merrypranxter/reposcripter2)**

The aesthetic layer that turns noise and geometry into beauty. Structured knowledge about color spaces, palette generation, procedural gradients, and tonemapping — with working GLSL/WGSL implementations. The third piece of the trilogy alongside [noise_fields](https://github.com/merrypranxter/noise) (texture) and [sdf_fields](https://github.com/merrypranxter/sdf_fields) (geometry).

## What This Is

A **knowledge base** encoding:

- **Color spaces** — RGB, HSB, HSL, Oklab, Oklch with conversion functions and guidance on when to use each
- **Palettes** — 10 curated semantic palettes (neon acid, volcanic, deep ocean, cosmic void, etc.)
- **Gradients** — IQ cosine palettes, black body radiation, perceptual rainbow
- **Tonemapping** — ACES, Reinhard, Uncharted 2, AgX with exposure/contrast/vignette utilities
- **Recipes** — Complete color treatments mapping "neon noise" or "lava glow" to shader code

## Quick Start

```bash
git clone https://github.com/merrypranxter/color_fields.git
```

Browse:
```bash
cat color_fields/palettes/neon_acid.json    # Electric cyberpunk colors
cat color_fields/gradients/cosine_palette.json  # IQ's magic palette function
cat color_fields/spaces/oklab.json          # The best color space for gradients
```

## Color Spaces

| Space | Good For | Bad For |
|-------|----------|---------|
| **RGB** | Direct display, blending modes | Perceptual work, hue rotation |
| **HSB** | Rainbow gradients, hue cycling | Uniform brightness perception |
| **HSL** | Tinting, pastel generation | Professional color grading |
| **Oklab** | Smooth gradients, palette interpolation | Nothing — best general purpose |
| **Oklch** | Perceptual hue rotation, constant-brightness sweeps | Direct display (needs conversion) |

## Palettes

| Palette | Vibe | Good For |
|---------|------|----------|
| **Neon Acid** | Electric, rave, cyberpunk | Psychedelic art, glitch, high-energy |
| **Volcanic** | Lava, fire, magma | Emissive surfaces, heat maps |
| **Deep Ocean** | Underwater, cold abyss | Depth fog, caustics, cool tones |
| **Bone & Rust** | Decay, aged earth | Weathered materials, desert, patina |
| **Cosmic Void** | Space, nebula, ethereal | Dark abstract, void effects |
| **Toxic Growth** | Radioactive, bioluminescent | Alien biology, fungal horror |
| **Ice Crystal** | Frozen, glass, winter | Crystalline structures, cold |
| **Sunset Gradient** | Warm sky, golden hour | Atmospheric, backgrounds |
| **Monochrome Ink** | Noir, minimal, pen | Ink effects, technical, grayscale |
| **Aurora** | Northern lights, magic | Ethereal glow, atmospheric bands |

## Gradients

| Gradient | Method | Key Feature |
|----------|--------|-------------|
| **IQ Cosine Palette** | `a + b * cos(2π(ct + d))` | 4 vec3 params = infinite palettes |
| **Black Body** | Physics-based temperature | Lava, stars, heat visualization |
| **Spectral Rainbow** | Oklch hue sweep | Perceptually uniform rainbow |

5 cosine palette presets included: sunset, fire, ocean, neon, pastel.

## Tonemapping

| Operator | Character |
|----------|-----------|
| **ACES** | Industry standard filmic, nice highlight rolloff |
| **Reinhard** | Simple and soft, good default |
| **Uncharted 2** | Dramatic S-curve, crushed blacks |
| **AgX** | Modern, best hue preservation |

Plus utilities: exposure, contrast, vignette, gamma correction.

## Recipes

| Recipe | What It Does |
|--------|-------------|
| **Noise to Neon** | Map noise → neon acid cosine palette |
| **Lava Emission** | SDF distance → black body gradient |
| **Depth Fog Ocean** | Ray march distance → deep ocean fog |
| **Normal Rainbow** | Surface normals → Oklch spectral rainbow |
| **AO Patina** | Ambient occlusion → bone & rust tinting |
| **Cosmic Glow** | Volumetric accumulation → cosmic void palette |

## Repository Layout

```
color_fields/
  pack.json
  spaces/       5 color space descriptors
  palettes/     10 semantic palettes
  gradients/    3 gradient generators (cosine w/ 5 presets)
  tonemapping/  4 tonemapping operators
  recipes/      6 color treatment recipes
  shaders/
    glsl/       color_spaces.glsl, gradients.glsl, tonemapping.glsl
    wgsl/       matching WGSL implementations
docs/ examples/
```

## Companion Packs

- **[noise_fields](https://github.com/merrypranxter/noise)** — Procedural noise for texture and displacement
- **[sdf_fields](https://github.com/merrypranxter/sdf_fields)** — SDF geometry, ray marching, lighting

## How RepoScripter Uses This

1. **Match** palette to mood via `style_tags` ("volcanic", "cosmic", "neon")
2. **Select** gradient function (cosine palette for variety, black body for heat)
3. **Choose** color space for interpolation (Oklab for smooth, HSB for trippy)
4. **Apply** tonemapping for final HDR→LDR (ACES default, AgX for accuracy)
5. **Compose** with noise_fields values and sdf_fields lighting for complete renders

## License

MIT — see [LICENSE](LICENSE).
