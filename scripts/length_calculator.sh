#!/bin/bash
# ============================================================================
# LENGTH CALCULATOR - Binding Length Recommendation Tool
# ============================================================================
# Calculates needed binding length with 15% safety margin
# Recommends appropriate preset based on measurement
#
# Usage: ./length_calculator.sh <measured_perimeter_mm>
# Example: ./length_calculator.sh 890
# ============================================================================

set -e

if [ $# -eq 0 ]; then
    echo "=== GUITAR BINDING LENGTH CALCULATOR ==="
    echo ""
    echo "Usage: $0 <measured_perimeter_mm>"
    echo "Example: $0 890"
    echo ""
    echo "HOW TO MEASURE:"
    echo "1. Use flexible measuring tape around guitar body edge"
    echo "2. Measure where the binding will actually go (not on the top!)"
    echo "3. Note the measurement in millimeters"
    echo "4. Run this script with that measurement"
    exit 1
fi

MEASURED=$1

# Validate input is a number
if ! [[ "$MEASURED" =~ ^[0-9]+$ ]]; then
    echo "ERROR: Please provide a valid number (measured perimeter in mm)"
    echo "Example: $0 890"
    exit 1
fi

echo "=== GUITAR BINDING LENGTH CALCULATOR ==="
echo ""
echo "Measured perimeter: ${MEASURED}mm"
echo ""

# Calculate with 15% safety margin
SAFETY_MARGIN=0.15
NEEDED=$(echo "$MEASURED * (1 + $SAFETY_MARGIN)" | bc)
NEEDED_INT=${NEEDED%.*}

echo "With 15% safety margin: ${NEEDED_INT}mm"
echo "(Formula: measured × 1.15 = $MEASURED × 1.15 = ${NEEDED_INT}mm)"
echo ""

# Recommend preset based on needed length
echo "=== RECOMMENDED PRESET ==="
echo ""

if [ "$NEEDED_INT" -le 500 ]; then
    echo "✓ RECOMMENDED: mandolin_binding (500mm)"
    echo "  Perfect for: Mandolin, ukulele, small instruments"
    echo "  Command: ./print_this.sh mandolin_binding"
    echo ""
    echo "  Your measurement: ${MEASURED}mm"
    echo "  With safety margin: ${NEEDED_INT}mm"
    echo "  Preset provides: 500mm"
    echo "  Extra safety: $((500 - NEEDED_INT))mm"
    
elif [ "$NEEDED_INT" -le 800 ]; then
    echo "✓ RECOMMENDED: electric_standard (800mm)"
    echo "  Perfect for: Stratocaster, Telecaster, Les Paul, SG"
    echo "  Command: ./print_this.sh electric_standard"
    echo ""
    echo "  Your measurement: ${MEASURED}mm"
    echo "  With safety margin: ${NEEDED_INT}mm"
    echo "  Preset provides: 800mm"
    echo "  Extra safety: $((800 - NEEDED_INT))mm"
    
elif [ "$NEEDED_INT" -le 1000 ]; then
    echo "✓ RECOMMENDED: acoustic_standard (1000mm)"
    echo "  Perfect for: Dreadnought, OM, 000, Grand Auditorium"
    echo "  Command: ./print_this.sh acoustic_standard"
    echo ""
    echo "  Your measurement: ${MEASURED}mm"
    echo "  With safety margin: ${NEEDED_INT}mm"
    echo "  Preset provides: 1000mm"
    echo "  Extra safety: $((1000 - NEEDED_INT))mm"
    
elif [ "$NEEDED_INT" -le 1200 ]; then
    echo "✓ RECOMMENDED: acoustic_jumbo (1200mm)"
    echo "  Perfect for: Jumbo, Grand Jumbo, large-body acoustics"
    echo "  Command: ./print_this.sh acoustic_jumbo"
    echo ""
    echo "  Your measurement: ${MEASURED}mm"
    echo "  With safety margin: ${NEEDED_INT}mm"
    echo "  Preset provides: 1200mm"
    echo "  Extra safety: $((1200 - NEEDED_INT))mm"
    
else
    echo "⚠ WARNING: Your guitar needs more than 1200mm!"
    echo ""
    echo "  Your measurement: ${MEASURED}mm"
    echo "  With safety margin: ${NEEDED_INT}mm"
    echo "  Largest preset: acoustic_jumbo (1200mm)"
    echo "  Shortfall: $((NEEDED_INT - 1200))mm"
    echo ""
    echo "OPTIONS:"
    echo "1. Edit acoustic_jumbo.scad and increase strip_length_mm to ${NEEDED_INT}"
    echo "2. Make multiple prints and splice them"
    echo "3. Reduce safety margin (risky - you might run short)"
fi

echo ""
echo "=== ALTERNATIVE: PURFLING ===" 
echo ""
echo "For decorative rosette purfling (not body binding):"
echo "  classical_purfling_bwb (600mm, Black-White-Black pattern)"
echo "  Command: ./print_this.sh classical_purfling_bwb"
echo ""

echo "=== NEXT STEPS ==="
echo "1. Run the recommended command above"
echo "2. Import the generated .3mf into Bambu Studio"
echo "3. Slice and print!"
echo ""
echo "For more help: See docs/START_HERE.md"
