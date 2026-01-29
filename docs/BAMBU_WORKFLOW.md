# Bambu Studio Workflow

Complete step-by-step guide for importing and slicing guitar binding in Bambu Studio.

---

## Overview

This workflow assumes you've already run:
```bash
./scripts/print_this.sh <preset_name>
```

Which generated a ready-to-import `.3mf` file in `examples/output/`.

---

## Method 1: Import .3MF File (Recommended - Fastest)

The generated `.3mf` file includes all settings pre-configured.

### Step 1: Open Bambu Studio

Launch Bambu Studio application.

### Step 2: Open Project

- **File → Open Project**
- Navigate to `examples/output/`
- Select `<preset_name>.3mf`
- Click **Open**

### Step 3: Verify Import

You should see:
- ✓ Spiral binding visible on build plate
- ✓ Centered on bed
- ✓ All stripes present (for purfling)
- ✓ Filament assignments in part list (right panel)

### Step 4: Check Filament Assignments

**For single-color binding:**
- Part 1 → Filament P1 (choose your color)

**For multi-color purfling:**
- Stripe 1 (Black) → Filament P1
- Stripe 2 (White) → Filament P2  
- Stripe 3 (Black) → Filament P3

**To change:** Click part in list → Filament dropdown → Select slot

### Step 5: Review Print Settings

The .3mf includes these settings (verify they're active):

**Filament:**
- Type: ABS
- Nozzle temp: 260°C
- Bed temp: 100°C

**Quality:**
- Layer height: 0.2mm (recommended)
- First layer height: 0.2mm

**Support:**
- None needed (binding prints flat)

**Adhesion:**
- Brim: 5mm width (important for ABS!)

### Step 6: Slice

- Click **Slice Plate** button (top right)
- Wait for slicing to complete (10-30 seconds)

### Step 7: Review Toolpath

In preview mode:
- ✓ Brim connects to all coils
- ✓ No gaps in perimeters
- ✓ Clean layer transitions
- ✓ Estimated time reasonable (2-7 hours typical)

### Step 8: Send to Printer

- **Print Plate** button
- Or save G-code to SD card/USB
- Or send via network if printer is connected

---

## Method 2: Manual STL Import (If .3MF Failed)

If the .3mf file didn't generate or you prefer manual control:

### Step 1: Import STL Files

- **File → Import → Import STL**
- Navigate to `examples/output/`
- **Select ALL stripe STL files at once** (hold Ctrl/Cmd)
  - Example: `acoustic_standard_L1000_W6_H1.5_Binding.stl`
  - Or all three: `*_Black.stl`, `*_White.stl`, `*_Black.stl`
- Click **Open**

**Important:** Import all files simultaneously to preserve alignment!

### Step 2: Verify Alignment

Parts should be:
- Overlapping/coincident (multi-color purfling)
- At same XY position
- Sharing the same coordinate system

**If misaligned:**
- Delete all parts
- Re-import selecting all STLs at once
- Or use the .3mf file (Method 1)

### Step 3: Assign Filaments

For each part in the list:
- Right-click part → Filament
- Select appropriate slot (P1, P2, P3...)

### Step 4: Apply ABS Profile

**Filament Settings:**
- Type: ABS or Generic ABS
- Nozzle temperature: 260°C
- Bed temperature: 100°C
- Bed type: Textured PEI recommended
- Flow rate: 100% (adjust if needed)

**Print Settings:**
- Layer height: 0.2mm
- Wall loops: 2-3
- Top/bottom layers: 3-4
- Infill: 15-20% (doesn't matter much for this geometry)
- Print speed: 100mm/s outer wall, 150mm/s inner

**Supports:** None

**Adhesion:**
- Brim: **Enable**
- Brim width: 5mm minimum (8-10mm if having warp issues)
- Brim-object gap: 0mm

### Step 5: Slice & Print

Continue from Method 1, Step 6.

---

## Recommended ABS Profile Settings

### Temperature Settings

| Parameter | Value | Notes |
|-----------|-------|-------|
| Nozzle (first layer) | 265°C | Higher for better bed adhesion |
| Nozzle (other layers) | 260°C | Standard ABS temp |
| Bed (first layer) | 100°C | Critical for ABS adhesion |
| Bed (other layers) | 100°C | Keep consistent |
| Chamber | Auto/Recommended | Let it heat naturally |

### Speed Settings

| Parameter | Value | Notes |
|-----------|-------|-------|
| First layer speed | 30-50mm/s | Slower for better adhesion |
| Outer wall speed | 80-100mm/s | Balance quality/time |
| Inner wall speed | 100-150mm/s | Can be faster |
| Travel speed | 200mm/s | Standard |

### Cooling Settings

| Parameter | Value | Notes |
|-----------|-------|-------|
| Fan speed (first layer) | 0% | Critical for ABS! |
| Fan speed (other layers) | 0-20% | Minimal cooling for ABS |
| Chamber fan | Off or Low | Keep heat in |

### First Layer Settings

| Parameter | Value | Notes |
|-----------|-------|-------|
| First layer height | 0.2mm | Match layer height |
| First layer width | 120% | Better adhesion |
| First layer speed | 30-50mm/s | Slower |

---

## Multi-Color Purfling Tips

### Filament Assignments

**For Black-White-Black pattern:**
1. Load Black ABS in P1
2. Load White ABS in P2
3. Load Black ABS in P3 (or reuse P1 if supported)

### Purge Settings

**Important for clean color transitions:**
- Purge volume: 70-100mm³ per color change
- Bambu Studio → Filament Settings → Purge Volume
- Higher values = cleaner transitions, more waste

### Color Sequence

The slicer should automatically:
- Print all Black sections with P1
- Switch to White for center stripe (P2)
- Switch back to Black for outer stripe (P3)

**Verify in layer preview:** Colors should align with your design.

---

## Post-Slice Verification Checklist

Before printing, verify in toolpath preview:

- [ ] Brim surrounds entire print (no gaps)
- [ ] First layer squish looks good (not air gaps, not over-squished)
- [ ] All stripes present and aligned
- [ ] No retraction issues (stringing unlikely with this geometry)
- [ ] Estimated time reasonable:
  - 500mm: ~2-3 hours
  - 1000mm: ~4-6 hours
  - 1200mm: ~5-7 hours

---

## Saving as Template (Advanced)

To reuse these settings for future binding prints:

### Step 1: Configure Once

Set up all settings (profile, brim, temps) as desired.

### Step 2: Save Project

- **File → Save Project As**
- Name: `binding_abs_template.3mf`
- Save to a templates folder

### Step 3: Reuse

Next time:
- Open template
- Import new STLs
- Previous settings already applied!

---

## Troubleshooting

### "Parts are in different locations"

**Cause:** Imported STLs separately
**Solution:** Delete all, re-import selecting all STLs at once

### "First layer not sticking"

**Causes:**
- Bed not clean (wipe with IPA)
- Not enough glue stick
- Bed temperature too low

**Solutions:**
- Apply fresh glue stick (heavy coat)
- Increase bed temp to 105-110°C
- Ensure chamber is closed

### "Warping during print"

**See full solutions in:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

**Quick fixes:**
- Increase brim to 8-10mm
- Enable breakaway ties in preset
- Close enclosure fully

### "Colors bleeding together"

**Cause:** Insufficient purge volume
**Solution:**
- Increase purge volume to 100mm³
- Check AMS wipe sequence is enabled

---

## Print Start Checklist

Before hitting print:

- [ ] AMS loaded with correct colors
- [ ] Filament path clear (no tangles)
- [ ] Build plate clean + glue stick applied
- [ ] Enclosure can close fully
- [ ] Estimated time fits your schedule
- [ ] **IMPORTANT:** Do not open enclosure during print (ABS warp!)

---

## After Slicing

1. **Save project** (for potential reprints)
2. **Start print**
3. **Watch first layer** (most critical!)
4. Let print complete without opening enclosure
5. Allow 10-15 min cool-down before removing

---

## Need More Help?

- **Print failed?** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Want to adjust dimensions?** See [ADVANCED_CUSTOMIZATION.md](ADVANCED_CUSTOMIZATION.md)
- **ABS printing tips:** Check Bambu Lab wiki for detailed ABS guidance

---

## Next Steps

✅ Sliced successfully
✅ Settings verified
→ **Print!**
→ After print: Carefully uncoil following tips in TROUBLESHOOTING.md
→ Test fit on guitar before gluing
