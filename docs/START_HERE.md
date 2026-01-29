# Which Preset Should I Use?

**Welcome to the Guitar Binding Generator!** This guide will help you choose the right preset for your instrument.

## Quick Decision Tree

### Step 1: What instrument do you have?

- **Acoustic guitar** → Continue to Step 2
- **Electric guitar** → Use **`electric_standard`** ✓
- **Classical guitar (rosette decoration)** → Use **`classical_purfling_bwb`** ✓  
- **Mandolin or Ukulele** → Use **`mandolin_binding`** ✓

### Step 2: Acoustic Guitar Body Size

- **Standard size** (Dreadnought, OM, 000, Grand Auditorium) → Use **`acoustic_standard`** ✓
- **Jumbo or Large body** (Jumbo, Grand Jumbo) → Use **`acoustic_jumbo`** ✓
- **Not sure? Measured your guitar?** → Continue to Step 3

### Step 3: Use the Length Calculator

If you've already measured your guitar's perimeter:

```bash
cd scripts
./length_calculator.sh <your_measurement_in_mm>
```

**Example:**
```bash
./length_calculator.sh 890
```

The calculator will recommend the best preset for your measurement with a built-in 15% safety margin.

---

## Preset Reference Chart

| Preset | Length | Width | For | Typical Use |
|--------|--------|-------|-----|-------------|
| **acoustic_standard** | 1000mm | 6mm | Dreadnought, OM, 000, Grand Auditorium | Most common acoustic guitars |
| **acoustic_jumbo** | 1200mm | 6mm | Jumbo, Grand Jumbo | Large-body acoustics |
| **electric_standard** | 800mm | 5mm | Strat, Tele, Les Paul, SG | Most electric guitars |
| **classical_purfling_bwb** | 600mm | 5.5mm | Classical rosette | Decorative 3-color inlay |
| **mandolin_binding** | 500mm | 4mm | Mandolin, ukulele | Small instruments |

---

## Once You've Chosen a Preset

### Quick Start Command

```bash
cd scripts
./print_this.sh <preset_name>
```

**Example:**
```bash
./print_this.sh acoustic_standard
```

This will:
1. ✓ Export STL files with dimensions in filenames
2. ✓ Validate geometry (manifold check, volume calculation)
3. ✓ Generate a ready-to-import `.3mf` file with ABS settings
4. ✓ Print summary and next steps

### Next Steps

1. **Import to Bambu Studio:** Open the generated `.3mf` file
2. **Verify Settings:** Check that filaments are assigned correctly
3. **Slice:** Review the toolpath and estimated time
4. **Print:** Hit that print button!

---

## Need More Help?

- **Don't know your guitar's perimeter?** → See [MEASURING_GUIDE.md](MEASURING_GUIDE.md)
- **Want to ensure a successful print?** → See [PRINT_SUCCESS_CHECKLIST.md](PRINT_SUCCESS_CHECKLIST.md)
- **Print failed or having issues?** → See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Want to customize parameters?** → See [ADVANCED_CUSTOMIZATION.md](ADVANCED_CUSTOMIZATION.md)

---

## Still Not Sure?

**Common Guitar Types:**
- **Dreadnought** (Martin D-28, Taylor 110) → `acoustic_standard`
- **OM / Orchestra Model** (Martin OM-28) → `acoustic_standard`
- **Jumbo** (Gibson J-200, Guild F-50) → `acoustic_jumbo`
- **Stratocaster** (Fender Strat) → `electric_standard`
- **Telecaster** (Fender Tele) → `electric_standard`
- **Les Paul** (Gibson LP) → `electric_standard`

**When in doubt:** Measure your guitar's perimeter and use the length calculator!
