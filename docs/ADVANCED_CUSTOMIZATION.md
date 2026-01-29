# Advanced Customization Guide

For power users who want to modify parameters, create custom presets, or understand the underlying system.

---

## Quick Parameter Reference

### Main Dimensions

| Parameter | Default | Range | Description |
|-----------|---------|-------|-------------|
| `strip_length_mm` | 1000 | 300-2000 | Usable length when uncoiled |
| `strip_width_mm` | 6.0 | 3.0-10.0 | Total width across all stripes |
| `strip_height_mm` | 1.5 | 1.0-3.0 | Thickness (Z dimension) |

### Spiral Parameters

| Parameter | Default | Range | Description |
|-----------|---------|-------|-------------|
| `min_inner_radius_mm` | 15 | 10-30 | Minimum bend radius (larger = safer uncoiling) |
| `spiral_pitch_mm` | 8.0 | 6-15 | Distance between coil centerlines |
| `clearance_mm` | 2.0 | 1.0-5.0 | Extra gap between coils (warp safety) |

**Critical constraint:** `spiral_pitch_mm ≥ strip_width_mm + clearance_mm`

### Manufacturing Adjustments

| Parameter | Default | Range | Description |
|-----------|---------|-------|-------------|
| `edge_radius_mm` | 0.3 | 0-1.0 | Edge rounding (0 = sharp) |
| `kerf_allowance_mm` | 0.0 | -0.5 to 0.5 | Dimensional compensation |
| `step_mm` | 0.8 | 0.3-2.0 | Path resolution (smaller = smoother) |

### Breakaway Ties (Optional)

| Parameter | Default | Range | Description |
|-----------|---------|-------|-------------|
| `tie_every_turns` | 0 | 0-5 | Ties every N turns (0 = disabled) |
| `tie_width_mm` | 0.8 | 0.5-2.0 | Tie width |
| `tie_thickness_mm` | 0.6 | 0.3-1.5 | Tie thickness |

---

## Using OpenSCAD Customizer (GUI)

The easiest way to adjust parameters without editing code:

### Step 1: Open Preset in OpenSCAD

```bash
open -a OpenSCAD presets/acoustic_standard.scad
# or double-click the .scad file
```

### Step 2: Open Customizer Panel

- **Window → Customizer** (or right-click on editor → Customizer)
- Panel appears on right side

### Step 3: Adjust Parameters

Parameters are organized into groups:
- **[Main Dimensions]**
- **[Purfling Stripes]**
- **[Spiral Parameters]**
- **[Manufacturing]**
- **[Advanced Options]**

Use **sliders** to adjust values.

### Step 4: Preview Changes

- Press **F5** to preview
- Adjust parameters
- Preview again until satisfied

### Step 5: Export

When happy with the result:
```bash
cd scripts
./export_all.sh ../presets/your_preset.scad
```

---

## Creating Custom Presets

### Method 1: Duplicate and Modify

```bash
cd presets
cp acoustic_standard.scad my_custom_binding.scad
```

Edit `my_custom_binding.scad`:
```scad
include <../src/guitar_binding.scad>

// Your custom parameters
strip_length_mm = 1100;  // Custom length
strip_width_mm = 7.0;    // Wider than standard
strip_height_mm = 1.8;   // Thicker

// Update documentation comment at top!
```

### Method 2: Create from Scratch

```scad
// my_preset.scad
/*
  MY CUSTOM BINDING
  
  For: [Your specific use case]
  Length: [X]mm
  Width: [Y]mm × Height: [Z]mm
  
  Notes: [Special considerations]
*/

include <../src/guitar_binding.scad>

// Override only what you need to change
strip_length_mm = 1500;
strip_width_mm = 5.5;

// Can add custom calculations
min_inner_radius_mm = strip_width_mm * 2.5;  // Dynamic calculation
spiral_pitch_mm = strip_width_mm + 3.0;
```

---

## Understanding Key Parameters

### Spiral Pitch Calculation

**Formula:** `spiral_pitch_mm ≥ strip_width_mm + clearance_mm`

**Why?** Prevents adjacent coils from touching/fusing.

**Example:**
- strip_width_mm = 6.0
- clearance_mm = 2.0
- Minimum pitch = 8.0mm ✓
- Using 7.5mm = ERROR (coils too close)

**Tip:** Use `pitch = width + 2.0` for standard clearance, `width + 3.0` for extra safety.

### Inner Radius Trade-offs

**Smaller radius (10-12mm):**
- ✓ Tighter coil
- ✓ Fits more length in same bed space
- ✗ Higher stress during uncoiling
- ✗ Risk of cracking

**Larger radius (18-20mm):**
- ✓ Easier to uncoil
- ✓ Less stress on material
- ✗ Fewer coil turns fit
- ✗ May need larger bed

**Recommendation:** 15mm is a good balance for ABS.

### Path Resolution (step_mm)

**Smaller values (0.3-0.5mm):**
- ✓ Very smooth spiral
- ✗ MUCH longer render time (2-5× slower)
- ✗ Larger STL file size

**Larger values (1.2-2.0mm):**
- ✓ Fast renders
- ✗ Visible faceting on curve
- ✗ May affect bed adhesion

**Recommendation:** 0.8mm balances quality and speed.

---

## Advanced Techniques

### Variable Width Binding (Not Yet Implemented)

Future feature: Taper from 6mm to 4mm along length.

**Current workaround:**
- Print two separate pieces
- Manual sanding/tapering

### Custom Purfling Patterns

Create multi-stripe with custom widths:

```scad
include <../src/guitar_binding.scad>

enable_purfling = true;
strip_width_mm = 6.5;  // Total width

// Custom 4-stripe pattern
purfling_stripe_1_name = "Black";
purfling_stripe_1_width = 1.5;
purfling_stripe_2_name = "White";
purfling_stripe_2_width = 1.0;
purfling_stripe_3_name = "Red";
purfling_stripe_3_width = 2.0;
purfling_stripe_4_name = "Black";
purfling_stripe_4_width = 2.0;

layers = [
    ["Black", 1.5],
    ["White", 1.0],
    ["Red", 2.0],
    ["Black", 2.0]
];
```

**Note:** Total must equal `strip_width_mm` (validated automatically).

### Kerf Adjustment for Tight Channels

If binding doesn't fit your routed channel:

```scad
kerf_allowance_mm = -0.2;  // Makes binding 0.2mm narrower overall
```

**How it works:**
- Applied to stripe width during sweep
- Negative = narrower (tight channels)
- Positive = wider (loose channels)

**Typical values:**
- -0.3mm: Very tight fit
- -0.2mm: Snug fit
- 0.0mm: As-designed (default)
- +0.1mm: Loose fit (gaps)

### Breakaway Ties for Problem Prints

If experiencing warping:

```scad
tie_every_turns = 2;  // Add tie every 2 coil turns
tie_width_mm = 1.0;   // Wider = stronger (but harder to remove)
tie_thickness_mm = 0.8; // Thicker = stronger
```

**Post-print:** Clip ties with flush cutters, file smooth.

---

## Understanding the Spiral Generator

### How It Works

1. **Archimedean spiral:** `r(θ) = r0 + (pitch / 2π) * θ`
2. **Iterative sampling:** Steps through angle `θ` in small increments
3. **Length accumulation:** Sums chord lengths until target reached
4. **Endpoint strategy:** Completes current turn for clean end
5. **Lead-in/out:** Adds straight segments tangent to spiral

### Algorithm Parameters

```scad
function spiral_points(
    target_len = strip_length_mm,     // Target length
    r0 = min_inner_radius_mm,         // Starting radius
    pitch = spiral_pitch_mm,          // Coil spacing
    step = step_mm,                   // Sample resolution
    lead_in = lead_in_mm,             // Straight start
    lead_out = lead_out_mm,           // Straight end
    complete_turn = true              // Complete coil?
)
```

**To modify behavior:** Edit `src/guitar_binding.scad` directly.

---

## BOSL2 Path Sweep Details

The core geometry uses BOSL2's `path_sweep()`:

```scad
module swept_stripe(path_pts, width, height, radius) {
    // Create 2D profile (rectangle)
    profile_2d = [[0,0], [width,0], [width,height], [0,height]];
    
    // Apply edge rounding (optional)
    profile = radius > 0 ? 
        round_corners(profile_2d, radius=radius) : 
        profile_2d;
    
    // Sweep along 3D path
    path_sweep(profile, path_pts, closed=false, twist=0);
}
```

**Parameters:**
- `closed=false`: Open path (not a loop)
- `twist=0`: No rotation along path
- Profile stays perpendicular to path

**To customize geometry:** Modify `stripe_profile()` module.

---

## Dimensional Validation

The system checks constraints automatically:

```scad
// Width validation
assert(
    sum_widths(layers) == strip_width_mm,
    "Layer widths must sum to strip_width_mm"
);

// Pitch validation
assert(
    spiral_pitch_mm >= strip_width_mm + clearance_mm,
    "Pitch too small - coils will collide"
);
```

**These prevent common errors.** If assertion fails, OpenSCAD shows error message.

---

## Performance Tuning

### Faster Renders

```scad
step_mm = 1.2;              // Coarser sampling (default 0.8)
strip_length_mm = 300;      // Test with short length first
```

### Smoother Geometry

```scad
step_mm = 0.5;              // Finer sampling (slower!)
edge_radius_mm = 0.5;       // More rounded edges
```

### Memory Issues

If OpenSCAD runs out of memory on very long strips:
- Increase `step_mm` to reduce points
- Split into two shorter segments
- Upgrade RAM (this can be memory-intensive!)

---

## Export CLI Options

### Export Specific Stripe Only

```bash
openscad -o stripe_A.stl -D 'export_part="Black"' my_preset.scad
```

### Batch Export with Custom Parameters

```bash
for length in 900 1000 1100; do
    openscad -o "binding_${length}mm.stl" \
        -D "strip_length_mm=${length}" \
        presets/acoustic_standard.scad
done
```

---

## Troubleshooting Custom Presets

### "Assertion failed: Layer widths..."

**Cause:** Stripe widths don't sum to total width

**Solution:**
```scad
// Must match:
strip_width_mm = 6.0;
layers = [["A", 3.0], ["B", 3.0]];  // 3.0 + 3.0 = 6.0 ✓
```

### "Render taking forever"

**Causes:**
- `step_mm` too small (< 0.5)
- `strip_length_mm` very large (> 2000)
- Computer low on RAM

**Solutions:**
- Increase `step_mm` to 1.0 or 1.2
- Test with quick_test.scad first
- Close other applications

### "Exported STL looks faceted"

**Cause:** `step_mm` too large or `$fn` too low

**Solution:**
```scad
step_mm = 0.6;  // Reduce step size
```

---

## Contributing Custom Presets

If you create a useful preset, consider contributing:

1. Document clearly (copy header style from existing presets)
2. Test print and validate
3. Include photo of result
4. Submit pull request with preset file

See [CONTRIBUTING.md](../CONTRIBUTING.md) for details.

---

## Need Help?

- **Parameter not working as expected?** Check console for error messages
- **Want to add new feature?** Open a discussion/issue on GitHub
- **Found a bug?** Please report with:
  - Preset file
  - OpenSCAD version
  - Error messages
  - Expected vs. actual behavior
