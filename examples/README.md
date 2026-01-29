# Example STL Files

This directory contains example STL outputs from the presets.

## Generating Examples

Example STLs are **not included in the repository** (they're large binary files). Generate them locally:

### Prerequisites

1. **Install BOSL2** - See [../docs/BOSL2_SETUP.md](../docs/BOSL2_SETUP.md)
2. **Verify installation**:
   ```bash
   openscad ../src/quick_test.scad
   ```

### Generate Examples

#### Quick Test (Fast - Recommended First)

```bash
cd ../scripts
./print_this.sh ../src/quick_test
```

Output: `output/quick_test_L300_W6_H1.5_Binding.stl` (~30 seconds render)

#### All Presets

```bash
cd ../scripts

# Generate each preset
./print_this.sh acoustic_standard
./print_this.sh acoustic_jumbo
./print_this.sh electric_standard
./print_this.sh classical_purfling_bwb
./print_this.sh mandolin_binding
```

**Note:** Full-length presets take 3-10 minutes each to render.

### Output Location

All generated files appear in `examples/output/`:
- STL files: `<preset>_L<length>_W<width>_H<height>_<stripe>.stl`
- .3MF files: `<preset>.3mf`

### Git LFS (Optional)

If you want to commit example STLs to your fork:

1. **Install Git LFS**:
   ```bash
   # macOS
   brew install git-lfs
   
   # Linux
   sudo apt-get install git-lfs
   
   # Windows
   # Download from https://git-lfs.github.com/
   ```

2. **Initialize in repo**:
   ```bash
   cd ..
   git lfs install
   git lfs track "examples/*.stl"
   ```

3. **Commit STLs**:
   ```bash
   git add examples/*.stl
   git commit -m "Add: Example STL files"
   ```

### File Sizes

Typical STL sizes (compressed in Git LFS):
- quick_test (300mm): ~5-10 MB
- acoustic_standard (1000mm): ~15-25 MB
- acoustic_jumbo (1200mm): ~20-30 MB
- electric_standard (800mm): ~12-20 MB

**Total for all presets**: ~100-150 MB

---

## Validation

After generating examples, validate them:

```bash
cd ../scripts
./validate_geometry.py ../examples/output/*.stl
```

Expected output:
- ✓ Manifold geometry
- ✓ Volume calculations
- ✓ Bounding box info
- ✓ Alignment checks (multi-stripe)

---

## Using Examples

1. **Import to Bambu Studio**: Open the `.3mf` files directly
2. **Manual import**: Use individual STL files
3. **Validation testing**: Verify your BOSL2 setup works correctly
4. **Dimension reference**: Check actual exported sizes with calipers after printing

---

## Troubleshooting

### "OpenSCAD can't find BOSL2"

→ See [../docs/BOSL2_SETUP.md](../docs/BOSL2_SETUP.md#troubleshooting)

### "Render taking forever"

→ Normal for full-length presets (5-10 min). Start with quick_test.scad first.

### "Export script failed"

→ Ensure OpenSCAD is in your PATH:
```bash
which openscad
```

If not found, edit `export_all.sh` with full path to OpenSCAD executable.

---

## Clean Up

To remove generated files:

```bash
rm -rf output/*.stl output/*.3mf
```

These will be regenerated when needed.
