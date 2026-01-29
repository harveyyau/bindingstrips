# Print Success Checklist

Use this checklist **before hitting print** to ensure a successful binding strip print.

---

## ✅ Pre-Flight Checklist

### Filament & Materials

- [ ] **Sufficient filament available**
  - Single-color binding: 40-50g ABS minimum
  - Multi-color purfling: 25-30g total (distributed across colors)
  - Check your spool weight before starting!

- [ ] **Correct filament type**
  - ABS recommended (best uncoiling properties)
  - PETG works but may be stiffer
  - PLA not recommended (too brittle for tight coils)

- [ ] **Filament condition**
  - Dry filament (especially for ABS)
  - Not old/brittle
  - Check for tangles on spool

### Printer Setup

- [ ] **Build plate prepared**
  - Clean plate (no residue from previous prints)
  - Fresh glue stick applied (for ABS)
  - Plate leveled and calibrated

- [ ] **Bed size confirmed**
  - All presets fit 256×256mm beds (Bambu X1/P1S)
  - Spiral diameter visible in slicer preview
  - No overhangs off the bed

- [ ] **Enclosure ready** (for ABS)
  - Enclosure closed during print
  - Chamber will heat up naturally
  - No drafts or AC vents nearby

### Print Settings

- [ ] **Correct profile loaded**
  - ABS profile selected (if using .3mf, already set)
  - Nozzle temp: 260°C
  - Bed temp: 100°C
  - Chamber: Recommended/automatic

- [ ] **Brim enabled**
  - 5mm brim minimum (helps prevent warping)
  - Included in .3mf files by default
  - Check brim visibility in slicer preview

- [ ] **Filament assignments correct** (multi-color only)
  - P1 assigned to first stripe
  - P2 assigned to second stripe
  - P3 assigned to third stripe
  - Verify in Bambu Studio part list

### Time & Planning

- [ ] **Sufficient print time available**
  - Estimate from slicer (typically 2-7 hours)
  - Buffer time for potential issues
  - No rush to remove print immediately

- [ ] **Filament loaded in correct slots**
  - AMS loaded with required colors
  - Filament path clear
  - Test extrusion if needed

---

## 📊 Estimated Print Times & Materials

| Preset | Print Time | ABS Needed | Bed Size |
|--------|-----------|------------|----------|
| mandolin_binding | 2-3h | ~20g | 256×256mm |
| electric_standard | 3-4h | ~30g | 256×256mm |
| classical_purfling_bwb | 3-4h | ~25g (3 colors) | 256×256mm |
| acoustic_standard | 4-6h | ~40g | 256×256mm |
| acoustic_jumbo | 5-7h | ~50g | 256×256mm |

*Times based on Bambu X1C with 0.2mm layer height, 100mm/s speeds*

---

## 🧪 First Time? Print a Test!

### Recommended: Quick Test First

Before committing to a full-length print:

```bash
cd scripts
./print_this.sh ../src/quick_test
```

**Quick test benefits:**
- Only 300mm length (30-60 minute print)
- Validates your BOSL2 setup
- Tests ABS adhesion on your printer
- Confirms uncoiling technique works
- Catches any geometry issues early

**After test print:**
- Uncoil the 300mm strip carefully
- Check for brittleness or cracking
- Verify dimensional accuracy with calipers
- If successful → proceed to full-length print!

---

## 🔍 Slicer Preview Checks

Before sending to printer, verify in Bambu Studio:

### Visual Inspection

- [ ] **Spiral visible and centered on bed**
  - Clean coil pattern
  - No overlapping layers
  - Centered in build area

- [ ] **Brim surrounds entire print**
  - Connected brim around all coils
  - No gaps in brim
  - 5mm+ brim width

- [ ] **Layer preview looks clean**
  - No gaps or holes in layers
  - Consistent extrusion width
  - Smooth path transitions

### Multi-Color Verification (Purfling Only)

- [ ] **Stripes aligned in preview**
  - All colors share same path
  - No offset between stripes
  - Flush alignment (not staggered)

- [ ] **Color changes at correct locations**
  - Stripe widths match design
  - Colors alternate as expected
  - No mid-stripe color changes

---

## ⚠️ Common Pre-Print Issues

### "Spiral doesn't fit on bed"

**Problem:** Slicer shows red/orange bed overflow

**Causes:**
- Wrong printer profile selected
- Bed size set incorrectly

**Solution:**
- Confirm bed size: 256×256mm minimum
- All presets designed to fit Bambu X1/P1S
- Check printer selection in slicer

### "Estimated time seems very long"

**Problem:** 10+ hours for acoustic_standard

**Possible causes:**
- Low print speed set
- Very fine layer height (0.1mm)
- Slow first layer speed

**Solution:**
- Use 0.2mm layer height (good balance)
- 100mm/s print speed recommended
- First layer 50mm/s is fine

### "Not enough filament on spool"

**Problem:** Spool looks low, estimate shows 40g needed

**Solution:**
- Weigh your spool (most have weight printed on them)
- Subtract spool weight to get filament weight
- Add 10-15% buffer for waste/purge
- Better to swap spool before printing than mid-print!

---

## 🎯 Ready to Print!

Once all checkboxes are complete:

1. **Save your Bambu Studio project** (in case you need to reprint)
2. **Send to printer** or load .3mf via USB
3. **Monitor first layer** (most critical!)
4. **Check after ~30 minutes** to ensure good adhesion
5. **Let it complete** without opening enclosure (ABS warps!)

---

## 📋 Post-Print Checklist

After print completes:

- [ ] Let print cool naturally (at least 10-15 minutes)
- [ ] Remove from bed carefully (flex bed or use scraper)
- [ ] Remove brim with hobby knife
- [ ] Check for warping on coil edges
- [ ] Store flat until ready to use

---

## Need Help?

- **Print failed?** → See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Uncoiling issues?** → See TROUBLESHOOTING.md section on uncoiling
- **Dimensional problems?** → Check [ADVANCED_CUSTOMIZATION.md](ADVANCED_CUSTOMIZATION.md) for kerf adjustment
