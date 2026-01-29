# Troubleshooting Guide

Common issues and solutions for 3D-printed guitar binding.

---

## 🔧 Print Quality Issues

### Problem: Print Lifted/Warped at Corners

**Symptoms:**
- Spiral edges curling up during print
- First few coils detaching from bed
- Corners lifting despite brim

**Solutions:**

✅ **Increase bed adhesion:**
- Apply more glue stick (heavy coat, not light)
- Raise bed temperature to 105-110°C
- Enable larger brim (8-10mm instead of 5mm)

✅ **Enable breakaway ties:**
Edit your preset file and add:
```scad
tie_every_turns = 2;  // Adds stabilizing ties between coils
```
Then regenerate STLs. Clip ties off after printing.

✅ **Environmental factors:**
- Close printer enclosure fully
- Ensure no AC vents blowing on printer
- Wait for chamber to heat before starting

✅ **Material check:**
- Verify filament is dry (ABS absorbs moisture)
- Try different ABS brand if persistent

**If still failing:** Switch to quick_test.scad (300mm) to validate your printer settings without wasting filament.

---

### Problem: Stripes Don't Align in Bambu Studio

**Symptoms:**
- Multi-color stripes appear offset or separate in preview
- Colors don't sit flush when imported
- Gaps visible between stripes

**Root Cause:**
- Imported STL files separately at different times
- Each import created independent placement

**Solution:**

✅ **Import correctly:**
- Use the generated .3mf file (alignment already correct)
- OR import all STLs simultaneously:
  - Bambu Studio: File → Import → Import STL
  - Select ALL stripe files at once (hold Ctrl/Cmd)
  - Confirm "Align" option is checked

✅ **Verify alignment:**
```bash
cd scripts
./validate_geometry.py ../examples/output/preset_name_*.stl
```
Script checks alignment automatically.

**Prevention:** Always use `./print_this.sh` which generates properly aligned .3mf files.

---

### Problem: Strip Breaks When Uncoiling

**Symptoms:**
- Binding cracks when straightening
- Snaps at bends or coil transitions
- Brittle despite being fresh print

**Causes & Solutions:**

✅ **Inner radius too tight:**
- Check min_inner_radius_mm in preset
- Increase to 18-20mm for very long strips
- Reprint with looser coil

✅ **ABS too cold:**
- Let print come to room temperature first
- Use heat gun on LOW setting while uncoiling
- Work in warm room (20°C+)

✅ **Uncoiling technique:**
- Uncoil **slowly and gently**
- Don't force it straight immediately
- Let it relax into gradual curve first
- Warm specific sections that resist

✅ **Material issue:**
- Some ABS brands are more brittle
- Try different manufacturer
- Ensure filament isn't old/degraded

**Tip:** Practice on quick_test.scad (300mm) first to perfect your uncoiling technique!

---

### Problem: Not Enough Length / Ran Short

**Symptoms:**
- Binding fits 90% of guitar but runs out
- Didn't account for waste/trimming
- Need to print again

**Prevention:**

✅ **Use length calculator BEFORE printing:**
```bash
cd scripts
./length_calculator.sh <measured_mm>
```
Automatically adds 15% safety margin.

✅ **Measure correctly:**
- Follow [MEASURING_GUIDE.md](MEASURING_GUIDE.md)
- Measure on side edge, not top surface
- Double-check measurement

✅ **Choose next size up if close:**
- Between acoustic_standard (1000mm) and acoustic_jumbo (1200mm)?
- Choose jumbo for extra safety

**If already printed short:**
- Can you splice two pieces? (Not ideal but works)
- Reprint with next size up
- Edit preset to add 50-100mm extra

---

## 🖥️ Software Issues

### Problem: OpenSCAD Render Takes Forever / Freezes

**Symptoms:**
- "Rendering..." message for 20+ minutes
- OpenSCAD not responding
- CPU at 100% but no progress

**Causes & Solutions:**

✅ **Length too long for hardware:**
- Start with quick_test.scad (300mm) to verify setup
- Full-length renders take 5-10 minutes even on fast PCs
- Be patient - it's computing thousands of path points

✅ **Reduce step resolution:**
Edit preset, increase step_mm:
```scad
step_mm = 1.2;  // Instead of 0.8 (faster but slightly less smooth)
```

✅ **BOSL2 not installed correctly:**
- See [BOSL2_SETUP.md](BOSL2_SETUP.md)
- Verify library path in OpenSCAD preferences

**Normal render times:**
- quick_test (300mm): 30-60 seconds
- acoustic_standard (1000mm): 3-8 minutes
- acoustic_jumbo (1200mm): 5-10 minutes

If taking 30+ minutes, something is wrong.

---

### Problem: OpenSCAD Error: "BOSL2 not found"

**Symptoms:**
```
ERROR: Can't find file 'BOSL2/std.scad'
```

**Solution:**

✅ **Install BOSL2 library:**
1. See complete guide: [BOSL2_SETUP.md](BOSL2_SETUP.md)
2. Download BOSL2 from GitHub
3. Install to OpenSCAD libraries folder
4. Restart OpenSCAD

**Quick verification:**
```scad
include <BOSL2/std.scad>
cube(10);
```
Should render without errors.

---

### Problem: Export Script Fails / No STL Generated

**Symptoms:**
- Script says "Export complete" but no file exists
- Empty or 0-byte STL file
- Error messages in script output

**Debugging Steps:**

✅ **Check OpenSCAD is in PATH:**
```bash
which openscad
# Should show path like /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
```

If not found, add to PATH or edit export_all.sh to use full path.

✅ **Run OpenSCAD manually:**
```bash
openscad -o test.stl presets/acoustic_standard.scad
```
Watch for actual error messages.

✅ **Check preset file syntax:**
- Open preset in OpenSCAD GUI
- Look for red error messages in console
- Fix any syntax errors

---

## 📐 Dimensional Issues

### Problem: Binding Too Narrow or Too Wide for Channel

**Symptoms:**
- Strip doesn't fit in routed binding channel
- Too loose or too tight
- Gaps or binding won't insert

**Solutions:**

✅ **Measure your actual channel:**
- Use calipers to measure channel width
- Standard is 1.5-2.0mm deep × 5-6mm wide
- Your guitar may vary!

✅ **Adjust kerf allowance:**
Edit preset:
```scad
kerf_allowance_mm = -0.2;  // Makes binding 0.2mm narrower
// or
kerf_allowance_mm = 0.2;   // Makes binding 0.2mm wider
```

✅ **Test fit first:**
- Print quick_test.scad
- Test a small section in channel
- Adjust and reprint full length

**Tolerance:** Presets are designed for ±0.2-0.3mm tolerance with hand-fitting/sanding.

---

### Problem: Binding Too Thick (Height)

**Symptoms:**
- Binding sticks up above guitar surface
- Channel not deep enough
- Can't sand down enough

**Solution:**

✅ **Reduce strip_height_mm:**
Edit preset:
```scad
strip_height_mm = 1.3;  // Instead of 1.5mm
```

✅ **Measure channel depth first:**
- Use depth gauge or calipers
- Channel may be shallower than standard
- Match binding height to your actual channel

---

## 🎨 Multi-Color (Purfling) Issues

### Problem: Color Bleeding or Mixing

**Symptoms:**
- Colors not crisp/clean at transitions
- Previous color showing in current stripe
- Purge tower not working

**Solutions:**

✅ **Check AMS purge settings:**
- Increase purge volume between colors
- Bambu Studio: Filament Settings → Purge Volume
- 70-100mm³ for ABS recommended

✅ **Verify stripe order in .3mf:**
- Colors should match layer definitions
- P1 = first stripe, P2 = second, etc.

✅ **Clean nozzle between colors:**
- Use AMS wipe sequence
- Check for clogged nozzle

---

## 🆘 Still Having Issues?

1. **Check example STLs:** Compare your output with included examples (if using Git LFS)
2. **Validate geometry:** Run `./validate_geometry.py` on your STLs
3. **Try quick_test.scad:** Eliminate long render times while debugging
4. **Review BOSL2 setup:** Many issues trace back to library installation
5. **Ask for help:** Open an issue on GitHub with:
   - Preset used
   - OpenSCAD version
   - Error messages
   - Photo of failed print (if applicable)

---

## Prevention Best Practices

✅ **Always start with quick_test.scad** for new printers/materials
✅ **Use length_calculator.sh** before committing to a preset
✅ **Validate geometry** with the Python script after export
✅ **Review slicer preview carefully** before printing
✅ **Keep filament dry** (ABS especially!)
✅ **Document your successful settings** for future reference
