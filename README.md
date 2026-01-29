# 3D-Printed Guitar Binding & Purfling Generator

**Parametric OpenSCAD system for generating custom guitar binding and purfling strips as 3D-printable spirals.**

Print professional-quality binding in any color, any length, ready for installation on your guitar!

---

## Features

✅ **Use-case driven presets** - For acoustic, electric, classical, mandolin, and more  
✅ **One-click workflow** - From preset to ready-to-print .3mf in one command  
✅ **Multi-color purfling** - Black-White-Black patterns with perfect alignment  
✅ **Bambu Studio integration** - Auto-generated .3mf files with ABS settings  
✅ **Automatic validation** - Geometry checks ensure manifold, printable results  
✅ **Full customization** - GUI and code-level parameter adjustment  
✅ **Length calculator** - Recommends preset based on your measurement  

---

## Quick Start (5 Minutes)

### 1. Install BOSL2 Library (One-Time Setup)

```bash
# Download BOSL2 from: https://github.com/BelfrySCAD/BOSL2
# Copy to: ~/Documents/OpenSCAD/libraries/BOSL2/
```

**Detailed instructions:** [docs/BOSL2_SETUP.md](docs/BOSL2_SETUP.md)

### 2. Choose Your Preset

**Which guitar do you have?**
- Dreadnought, OM, 000 → `acoustic_standard`
- Jumbo, large-body → `acoustic_jumbo`
- Stratocaster, Telecaster, Les Paul → `electric_standard`
- Classical rosette → `classical_purfling_bwb`
- Mandolin, ukulele → `mandolin_binding`

**Not sure?** See [docs/START_HERE.md](docs/START_HERE.md)

### 3. Generate Print Files

```bash
cd scripts
./print_this.sh acoustic_standard
```

This will:
- ✓ Export STL files with dimensions in filenames
- ✓ Validate geometry (manifold, volume, alignment)
- ✓ Generate `.3mf` file with ABS settings pre-applied
- ✓ Print summary and next steps

### 4. Print in Bambu Studio

1. Open Bambu Studio
2. File → Open Project → `examples/output/acoustic_standard.3mf`
3. Verify filament assignments
4. Slice and print!

**Detailed workflow:** [docs/BAMBU_WORKFLOW.md](docs/BAMBU_WORKFLOW.md)

---

## Available Presets

| Preset | Length | Width | For | Print Time | Filament |
|--------|--------|-------|-----|------------|----------|
| **acoustic_standard** | 1000mm | 6mm | Dreadnought, OM, 000, Grand Auditorium | 4-6h | ~40g |
| **acoustic_jumbo** | 1200mm | 6mm | Jumbo, Grand Jumbo | 5-7h | ~50g |
| **electric_standard** | 800mm | 5mm | Strat, Tele, Les Paul, SG | 3-4h | ~30g |
| **classical_purfling_bwb** | 600mm | 5.5mm | Classical rosette (3-color) | 3-4h | ~25g |
| **mandolin_binding** | 500mm | 4mm | Mandolin, ukulele | 2-3h | ~20g |

All presets include detailed documentation and fit standard Bambu Lab 256×256mm beds.

---

## Project Structure

```
bindingstrips/
├── presets/                 # START HERE - Ready-to-use configurations
│   ├── acoustic_standard.scad
│   ├── acoustic_jumbo.scad
│   ├── electric_standard.scad
│   ├── classical_purfling_bwb.scad
│   └── mandolin_binding.scad
├── src/
│   ├── guitar_binding.scad  # Core library (advanced users)
│   └── quick_test.scad      # Fast 300mm test version
├── scripts/
│   ├── print_this.sh        # ONE-CLICK: Generate everything
│   ├── length_calculator.sh # "I need 890mm" → recommends preset
│   ├── export_all.sh        # Export STLs with dimension tagging
│   ├── generate_3mf.py      # Create Bambu .3mf files
│   └── validate_geometry.py # Quality checks
├── docs/
│   ├── START_HERE.md        # Decision tree for preset selection
│   ├── MEASURING_GUIDE.md   # How to measure your guitar
│   ├── PRINT_SUCCESS_CHECKLIST.md
│   ├── TROUBLESHOOTING.md   # Common issues & solutions
│   ├── BAMBU_WORKFLOW.md    # Bambu Studio step-by-step
│   ├── BOSL2_SETUP.md       # Library installation
│   └── ADVANCED_CUSTOMIZATION.md
└── examples/
    └── output/              # Generated STLs and .3mf files
```

---

## Documentation

### For Guitar Builders (Start Here!)

- **[START_HERE.md](docs/START_HERE.md)** - Which preset should I use?
- **[MEASURING_GUIDE.md](docs/MEASURING_GUIDE.md)** - How to measure your guitar's perimeter
- **[PRINT_SUCCESS_CHECKLIST.md](docs/PRINT_SUCCESS_CHECKLIST.md)** - Pre-flight checks before printing
- **[TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)** - "My print failed" → solutions

### Technical Documentation

- **[BOSL2_SETUP.md](docs/BOSL2_SETUP.md)** - Install OpenSCAD library (one-time, 10 min)
- **[BAMBU_WORKFLOW.md](docs/BAMBU_WORKFLOW.md)** - Import, slice, and print workflow
- **[ADVANCED_CUSTOMIZATION.md](docs/ADVANCED_CUSTOMIZATION.md)** - Parameter reference and custom presets

---

## Key Features Explained

### Parametric Spiral Generation

- **Archimedean spiral** with iterative length accumulation
- **Completes current coil turn** for clean endpoints
- **Lead-in/out straight segments** for easy handling
- **Adjustable pitch** to prevent coil collision

### Multi-Color Purfling

- **Perfectly flush stripes** at same Z-height (seamless appearance)
- **One STL per color** - robust multi-material workflow
- **Auto-aligned** - no manual positioning in slicer
- **Example:** Black-White-Black rosette decoration

### Quality Validation

- **Manifold check** - ensures watertight geometry
- **Volume calculation** - estimates filament usage
- **Dimension verification** - validates against parameters
- **Alignment check** - multi-stripe coordination

### One-Click .3MF Generation

- **All STLs pre-imported** and aligned
- **Filament slots pre-assigned** per stripe
- **ABS profile applied** (260°C / 100°C / 5mm brim)
- **Ready to slice** immediately in Bambu Studio

---

## Requirements

### Software
- **OpenSCAD** 2021.01 or newer ([download](https://openscad.org/downloads.html))
- **BOSL2 library** ([installation guide](docs/BOSL2_SETUP.md))
- **Bambu Studio** (for slicing)
- **Python 3** (for validation and .3mf generation)

### Hardware
- **3D Printer** with 256×256mm bed minimum (Bambu X1/P1S tested)
- **ABS filament** recommended (PETG works, PLA not recommended)

### Skills
- Basic command line usage (running shell scripts)
- Familiarity with 3D printing (ABS handling)
- Guitar binding installation knowledge (for post-print)

---

## Tips for Success

### First Time? Start with Quick Test!

```bash
cd scripts
./print_this.sh ../src/quick_test
```

- Only 300mm length (30-60 minute print)
- Validates your setup quickly
- Practice uncoiling technique
- Then proceed to full-length print

### Measuring Your Guitar

1. Use flexible measuring tape around body edge
2. Add 15% safety margin: `measured × 1.15`
3. Use length calculator:
   ```bash
   ./scripts/length_calculator.sh 890
   ```

### ABS Printing Tips

- **Glue stick** on bed (heavy coat)
- **Enclosure closed** during entire print
- **5mm+ brim** prevents warping
- **Let cool naturally** (10-15 min) before removing
- **Uncoil carefully** - warm with heat gun if needed

---

## Customization

### GUI Customization (No Code Editing)

1. Open preset in OpenSCAD
2. Window → Customizer
3. Adjust sliders for length, width, height, etc.
4. Preview (F5) to see changes
5. Export when satisfied

### Create Custom Preset

```bash
cd presets
cp acoustic_standard.scad my_custom.scad
# Edit parameters as needed
```

See [ADVANCED_CUSTOMIZATION.md](docs/ADVANCED_CUSTOMIZATION.md) for details.

---

## Troubleshooting

### "Print warped/lifted"
→ More glue stick, higher bed temp, enable breakaway ties  
→ See [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md#print-liftedwarped-at-corners)

### "Stripes don't align"
→ Import all STLs simultaneously, or use .3mf file  
→ See [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md#stripes-dont-align-in-bambu-studio)

### "Strip breaks when uncoiling"
→ Warm with heat gun, uncoil slowly, check inner radius  
→ See [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md#strip-breaks-when-uncoiling)

### "OpenSCAD won't render"
→ Verify BOSL2 installation, reduce step_mm, try quick_test  
→ See [BOSL2_SETUP.md](docs/BOSL2_SETUP.md#troubleshooting)

---

## Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Ways to help:**
- Report bugs or feature requests
- Improve documentation
- Create new presets for different instruments
- Submit code improvements
- Share photos of successful prints!

---

## License

MIT License - See [LICENSE](LICENSE) for details.

Free to use commercially and personally. Attribution appreciated but not required.

---

## Acknowledgments

- **BOSL2 Library** - Provides robust path_sweep geometry operations
- **Bambu Lab** - Excellent multi-material printing capabilities
- **OpenSCAD Community** - Parametric design foundation
- **Guitar builders** who provided feedback and testing

---

## Support

- **Issues:** Open a GitHub issue for bugs or feature requests
- **Discussions:** Ask questions or share your prints
- **Documentation:** All guides in `docs/` folder

---

## Roadmap

**Current Version:** 1.0 (Full-featured, production-ready)

**Potential Future Features:**
- Variable width (tapering) support
- Texture patterns for better glue adhesion
- Integration with other slicers (PrusaSlicer, Cura)
- Web-based configurator
- Additional instrument presets

**Want to contribute?** See [CONTRIBUTING.md](CONTRIBUTING.md)

---

## Gallery

**Share your prints!**  
Open a discussion with photos of your printed binding installed on guitars.

---

**Made with ❤️ for the guitar building community**

🎸 Happy printing and building! 🎸
