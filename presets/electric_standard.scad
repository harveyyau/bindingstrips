// ============================================================================
// ELECTRIC STANDARD BINDING
// ============================================================================
/*
  FOR: Stratocaster, Telecaster, Les Paul, SG, and most electric guitars
  
  TYPICAL PERIMETER: 700-800mm
  THIS PRESET PRODUCES: ~1600mm usable length (bed-filling spiral!)
  
  STRATEGY: Fills entire 240mm bed diameter for MAXIMUM outer bend radius
  → Starts at bed edge (120mm radius), spirals INWARD to center
  → Outer coils have gentle 120mm radius = very easy to unbend and install!
  → Same dimensions as acoustic (1.5mm × 6mm is universal)
  
  PRINT TIME: ~2-3 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~30-40g ABS (single color)
  BED REQUIREMENT: Fills Bambu X1/P1S (256×256mm bed) completely
  
  DIMENSIONS: 1.5mm WIDE × 6mm TALL (standard guitar binding profile)
*/
// ============================================================================

include <../src/guitar_binding.scad>

// Override parameters - Standard electric guitar binding (same as acoustic!)
strip_length_mm = 1600;  // [1000:100:3000] Plenty for any electric
strip_width_mm = 1.5;    // [1.0:0.5:3.0] Standard width
strip_height_mm = 6.0;   // [3.0:0.5:10.0] Standard height

// Single color binding
enable_purfling = false;
layers = [["Binding", 1.5]];

// BED-FILLING INWARD SPIRAL
max_bed_diameter_mm = 240;  // Full bed
min_center_radius_mm = 10;  // Spiral to center
clearance_mm = 1.0;         // 1mm gap (pitch auto = 1.5+1.0=2.5mm)

echo("=== ELECTRIC STANDARD BINDING (Inward Spiral) ===");
echo("For: Stratocaster, Telecaster, Les Paul, SG");
echo("Output: ~1600mm × 1.5mm WIDE × 6mm TALL (fills 240mm bed)");
echo("Spiral: 120mm outer radius (GENTLE!) → 10mm inner");
