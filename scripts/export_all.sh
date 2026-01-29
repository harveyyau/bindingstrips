#!/bin/bash
# ============================================================================
# EXPORT ALL STRIPES - Dimension-Tagged STL Export
# ============================================================================
# Exports each color stripe as a separate STL file with dimensions in filename
# Usage: ./export_all.sh <preset_scad_file>
# Example: ./export_all.sh ../presets/acoustic_standard.scad
# ============================================================================

set -e  # Exit on error

if [ $# -eq 0 ]; then
    echo "ERROR: No preset file specified"
    echo "Usage: $0 <preset_scad_file>"
    echo "Example: $0 ../presets/acoustic_standard.scad"
    exit 1
fi

PRESET_FILE="$1"
PRESET_NAME=$(basename "$PRESET_FILE" .scad)

if [ ! -f "$PRESET_FILE" ]; then
    echo "ERROR: Preset file not found: $PRESET_FILE"
    exit 1
fi

echo "=== GUITAR BINDING EXPORTER ==="
echo "Preset: $PRESET_NAME"
echo "File: $PRESET_FILE"
echo ""

# Extract dimensions from the preset file
echo "Extracting dimensions from preset..."
LENGTH=$(grep -E "^strip_length_mm\s*=" "$PRESET_FILE" | sed 's/.*=\s*\([0-9]*\).*/\1/' | head -1)
WIDTH=$(grep -E "^strip_width_mm\s*=" "$PRESET_FILE" | sed 's/.*=\s*\([0-9.]*\).*/\1/' | head -1)
HEIGHT=$(grep -E "^strip_height_mm\s*=" "$PRESET_FILE" | sed 's/.*=\s*\([0-9.]*\).*/\1/' | head -1)

if [ -z "$LENGTH" ] || [ -z "$WIDTH" ] || [ -z "$HEIGHT" ]; then
    echo "WARNING: Could not extract all dimensions from file, using defaults"
    LENGTH="1000"
    WIDTH="6.0"
    HEIGHT="1.5"
fi

echo "Dimensions: ${LENGTH}mm × ${WIDTH}mm × ${HEIGHT}mm"
echo ""

# Check if it's a multi-stripe (purfling) preset
IS_PURFLING=$(grep -c "enable_purfling = true" "$PRESET_FILE" || echo "0")

# Create output directory
OUTPUT_DIR="../examples/output"
mkdir -p "$OUTPUT_DIR"

if [ "$IS_PURFLING" -gt 0 ]; then
    # Multi-stripe purfling - export each color
    echo "Multi-stripe purfling detected"
    echo "Extracting stripe names..."
    
    # Extract stripe names from layers array
    STRIPES=$(grep -A 10 "layers = \[" "$PRESET_FILE" | grep "\[\"" | sed 's/.*\["\([^"]*\)".*/\1/' || echo "")
    
    if [ -z "$STRIPES" ]; then
        echo "WARNING: Could not extract stripe names, using defaults"
        STRIPES="Black White Black"
    fi
    
    echo "Stripes found: $STRIPES"
    echo ""
    
    # Export each stripe
    for STRIPE in $STRIPES; do
        OUTPUT_FILE="${OUTPUT_DIR}/${PRESET_NAME}_L${LENGTH}_W${WIDTH}_H${HEIGHT}_${STRIPE}.stl"
        echo "Exporting stripe: $STRIPE"
        echo "  Output: $OUTPUT_FILE"
        
        openscad -o "$OUTPUT_FILE" -D "export_part=\"$STRIPE\"" "$PRESET_FILE" 2>&1 | grep -E "(ERROR|WARNING|Compiling|Rendering)" || true
        
        if [ -f "$OUTPUT_FILE" ]; then
            SIZE=$(ls -lh "$OUTPUT_FILE" | awk '{print $5}')
            echo "  ✓ Export complete ($SIZE)"
        else
            echo "  ✗ Export failed"
        fi
        echo ""
    done
else
    # Single-color binding
    echo "Single-color binding detected"
    OUTPUT_FILE="${OUTPUT_DIR}/${PRESET_NAME}_L${LENGTH}_W${WIDTH}_H${HEIGHT}_Binding.stl"
    echo "Output: $OUTPUT_FILE"
    echo ""
    
    openscad -o "$OUTPUT_FILE" -D "export_part=\"Binding\"" "$PRESET_FILE" 2>&1 | grep -E "(ERROR|WARNING|Compiling|Rendering)" || true
    
    if [ -f "$OUTPUT_FILE" ]; then
        SIZE=$(ls -lh "$OUTPUT_FILE" | awk '{print $5}')
        echo "✓ Export complete ($SIZE)"
    else
        echo "✗ Export failed"
        exit 1
    fi
fi

echo ""
echo "=== EXPORT COMPLETE ==="
echo "Files saved to: $OUTPUT_DIR"
ls -lh "$OUTPUT_DIR"/${PRESET_NAME}_*.stl 2>/dev/null || echo "No files found"
