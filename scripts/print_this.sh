#!/bin/bash
# ============================================================================
# PRINT THIS - One-Click Workflow to .3MF
# ============================================================================
# Complete workflow from preset to ready-to-print .3MF file
#
# This script:
# 1. Validates preset exists
# 2. Exports all STL files with dimension-tagged filenames
# 3. Runs geometry validation (manifold check, dimensions)
# 4. Generates .3mf file with ABS profile and filament assignments
# 5. Outputs summary with next steps
#
# Usage: ./print_this.sh <preset_name>
# Example: ./print_this.sh acoustic_standard
# ============================================================================

set -e  # Exit on error

# Check for preset name argument
if [ $# -eq 0 ]; then
    echo "=== GUITAR BINDING: ONE-CLICK PRINT PREPARATION ==="
    echo ""
    echo "Usage: $0 <preset_name>"
    echo ""
    echo "Available presets:"
    echo "  acoustic_standard  - Dreadnought, OM, 000 (1000mm)"
    echo "  acoustic_jumbo     - Jumbo, large acoustics (1200mm)"
    echo "  electric_standard  - Strat, Tele, Les Paul (800mm)"
    echo "  classical_purfling_bwb - Classical rosette B-W-B (600mm)"
    echo "  mandolin_binding   - Mandolin, ukulele (500mm)"
    echo ""
    echo "Example: $0 acoustic_standard"
    echo ""
    echo "Not sure which to use? Run: ./length_calculator.sh <your_measurement>"
    exit 1
fi

PRESET_NAME="$1"
PRESET_FILE="../presets/${PRESET_NAME}.scad"

echo "=== GUITAR BINDING: ONE-CLICK WORKFLOW ==="
echo "Preset: $PRESET_NAME"
echo ""

# Step 1: Validate preset exists
if [ ! -f "$PRESET_FILE" ]; then
    echo "✗ ERROR: Preset not found: $PRESET_FILE"
    echo ""
    echo "Available presets:"
    ls -1 ../presets/*.scad 2>/dev/null | xargs -n1 basename | sed 's/.scad//' | sed 's/^/  /'
    exit 1
fi

echo "✓ Step 1: Preset validated"
echo ""

# Step 2: Export STL files
echo "Step 2: Exporting STL files..."
echo "  (This may take 2-10 minutes depending on length)"
echo ""

./export_all.sh "$PRESET_FILE"

if [ $? -ne 0 ]; then
    echo ""
    echo "✗ ERROR: STL export failed"
    exit 1
fi

echo ""
echo "✓ Step 2: STL export complete"
echo ""

# Step 3: Validate geometry (if Python script exists)
if [ -f "./validate_geometry.py" ]; then
    echo "Step 3: Validating geometry..."
    echo ""
    
    python3 ./validate_geometry.py ../examples/output/${PRESET_NAME}_*.stl
    
    if [ $? -ne 0 ]; then
        echo ""
        echo "⚠ WARNING: Geometry validation found issues"
        echo "  You can still proceed, but print quality may be affected"
        echo ""
        read -p "Continue anyway? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    else
        echo ""
        echo "✓ Step 3: Geometry validation passed"
        echo ""
    fi
else
    echo "⚠ Step 3: Skipping geometry validation (validate_geometry.py not found)"
    echo ""
fi

# Step 4: Generate .3MF file (if Python script exists)
if [ -f "./generate_3mf.py" ]; then
    echo "Step 4: Generating .3mf file..."
    echo "  Preset: $PRESET_NAME"
    echo "  Applying: Basic ABS profile (260°C / 100°C / 5mm brim)"
    echo ""
    
    python3 ./generate_3mf.py ../examples/output/${PRESET_NAME}_*.stl -o ../examples/output/${PRESET_NAME}.3mf
    
    if [ $? -ne 0 ]; then
        echo ""
        echo "✗ ERROR: .3MF generation failed"
        exit 1
    fi
    
    echo ""
    echo "✓ Step 4: .3MF file generated"
    echo ""
else
    echo "⚠ Step 4: Skipping .3MF generation (generate_3mf.py not found)"
    echo "  You'll need to manually import STLs into Bambu Studio"
    echo ""
fi

# Step 5: Summary and next steps
echo "=== ✓ PREPARATION COMPLETE ==="
echo ""
echo "Files generated:"
ls -lh ../examples/output/${PRESET_NAME}_*.stl 2>/dev/null || echo "  No STL files found"
if [ -f "../examples/output/${PRESET_NAME}.3mf" ]; then
    ls -lh ../examples/output/${PRESET_NAME}.3mf
fi
echo ""

if [ -f "../examples/output/${PRESET_NAME}.3mf" ]; then
    echo "=== NEXT STEPS ==="
    echo ""
    echo "1. Open Bambu Studio"
    echo "2. File → Open Project"
    echo "3. Select: examples/output/${PRESET_NAME}.3mf"
    echo "4. Verify filament assignments (should be pre-assigned)"
    echo "5. Slice and print!"
    echo ""
    echo "Print settings already applied in .3mf:"
    echo "  ✓ ABS profile (260°C nozzle, 100°C bed)"
    echo "  ✓ 5mm brim (warp prevention)"
    echo "  ✓ Filaments assigned to stripes"
    echo ""
    echo "Estimated print time: See preset documentation"
    echo "For troubleshooting: See docs/TROUBLESHOOTING.md"
else
    echo "=== NEXT STEPS (Manual Import) ==="
    echo ""
    echo "1. Open Bambu Studio"
    echo "2. Import all STL files:"
    ls -1 ../examples/output/${PRESET_NAME}_*.stl 2>/dev/null | sed 's|^|     |'
    echo "3. Assign filaments to each part"
    echo "4. Apply ABS profile (260°C / 100°C)"
    echo "5. Enable 5mm brim for warp prevention"
    echo "6. Slice and print!"
    echo ""
    echo "For detailed workflow: See docs/BAMBU_WORKFLOW.md"
fi

echo ""
echo "✓ Ready to print!"
