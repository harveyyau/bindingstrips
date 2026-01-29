// ============================================================================
// ACOUSTIC JUMBO BINDING
// ============================================================================
/*
  FOR: Jumbo, Grand Jumbo, and large-body acoustic guitars
  
  TYPICAL PERIMETER: 1000-1100mm
  THIS PRESET PRODUCES: ~2000mm usable length (bed-filling spiral!)
  
  STRATEGY: Fills entire 240mm bed diameter for MAXIMUM outer bend radius
  → Starts at bed edge (120mm radius), spirals INWARD to center
  → Outer coils have gentle 120mm radius = very easy to unbend and install!
  → Longer binding than standard (wider strip = less turns fit)
  
  PRINT TIME: ~3-4 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~40-50g ABS (single color)
  BED REQUIREMENT: Fills Bambu X1/P1S (256×256mm bed) completely
  
  DIMENSIONS: 2.0mm WIDE × 6mm TALL (slightly wider binding)
*/
// ============================================================================

include <../src/guitar_binding.scad>

// Override parameters - Wider binding for jumbo guitars
strip_length_mm = 2000;  // [1000:100:3000] Target length
strip_width_mm = 2.0;    // [1.5:0.5:4.0] Wider than standard
strip_height_mm = 6.0;   // [3.0:0.5:10.0] Standard height

// Single color binding
enable_purfling = false;
layers = [["Binding", 2.0]];

// BED-FILLING INWARD SPIRAL
max_bed_diameter_mm = 240;  // Full bed
min_center_radius_mm = 10;  // Spiral to center
clearance_mm = 1.0;         // 1mm gap (pitch auto = 2.0+1.0=3.0mm)

echo("=== ACOUSTIC JUMBO BINDING (Inward Spiral) ===");
echo("For: Jumbo, Grand Jumbo, large-body acoustics");
echo("Output: ~2000mm × 2.0mm WIDE × 6mm TALL (fills 240mm bed)");
echo("Spiral: 120mm outer radius (GENTLE!) → 10mm inner");
