// ============================================================================
// MANDOLIN BINDING
// ============================================================================
/*
  FOR: Mandolin, ukulele, and small stringed instruments
  
  TYPICAL PERIMETER: 400-500mm (varies by instrument)
  THIS PRESET PRODUCES: ~1800mm usable length (bed-filling spiral!)
  
  STRATEGY: Fills entire 240mm bed diameter for MAXIMUM outer bend radius
  → Starts at bed edge (120mm radius), spirals INWARD to center
  → Narrower binding fits more turns on bed
  → Outer coils have gentle radius = easy to install
  
  PRINT TIME: ~2-3 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~25-35g ABS (single color)
  BED REQUIREMENT: Fills Bambu X1/P1S (256×256mm bed) completely
  
  DIMENSIONS: 1.2mm WIDE × 5mm TALL (narrower for small instruments)
*/
// ============================================================================

include <../src/guitar_binding.scad>

// Override parameters - Narrower for mandolin/ukulele
strip_length_mm = 1800;  // [1000:100:3000] Plenty for small instruments
strip_width_mm = 1.2;    // [1.0:0.5:3.0] Narrower than guitar
strip_height_mm = 5.0;   // [3.0:0.5:10.0] Slightly shorter

// Single color binding
enable_purfling = false;
layers = [["Binding", 1.2]];

// BED-FILLING INWARD SPIRAL
max_bed_diameter_mm = 240;  // Full bed
min_center_radius_mm = 10;  // Spiral to center
clearance_mm = 1.0;         // 1mm gap (pitch auto = 1.2+1.0=2.2mm)

echo("=== MANDOLIN / SMALL INSTRUMENT BINDING (Inward Spiral) ===");
echo("For: Mandolin, ukulele, small stringed instruments");
echo("Output: ~1800mm × 1.2mm WIDE × 5mm TALL (fills 240mm bed)");
echo("Spiral: 120mm outer radius → 10mm inner");
