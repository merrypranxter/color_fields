# IQ Cosine Palettes

The single most useful color function in shader art.

## The Formula

```
color(t) = a + b * cos(2π(c*t + d))
```

Four `vec3` parameters (`a`, `b`, `c`, `d`) create infinite variety:

- `a` = bias (baseline color)
- `b` = amplitude (how much the cosine swings)
- `c` = frequency (how many color cycles per unit t)
- `d` = phase (shifts the starting hue)

## Tuning Guide

| Want | Adjust |
|------|--------|
| Brighter overall | Increase `a` |
| More saturated | Increase `b` |
| More color variety | Increase `c` |
| Shift starting hue | Change `d` |
| Pastel look | `a` = 0.8, `b` = 0.2 |
| Neon look | `a` = 0.5, `b` = 0.5, `c` = 2.0+ |
| Monochrome-ish | `b` = 0.1 |

## Included Presets

- **Sunset**: Classic balanced rainbow
- **Fire**: Warm orange-red bias
- **Ocean**: Cool blue-green bias
- **Neon**: High frequency, electric colors
- **Pastel**: Soft, muted tones

## Reference

[Inigo Quilez — Palettes](https://iquilezles.org/articles/palettes/)
