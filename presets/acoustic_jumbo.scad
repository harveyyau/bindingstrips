// ============================================================================
// ACOUSTIC JUMBO BINDING
// ============================================================================
/*
  FOR: Jumbo, Grand Jumbo, and large-body acoustic guitars
  
  TYPICAL PERIMETER: 1000-1100mm
  THIS PRESET PRODUCES: 1200mm usable length (includes 15% safety margin)
  
  PRINT TIME: ~5-7 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~50g ABS (single color)
  BED REQUIREMENT: Fits Bambu X1/P1S (256×256mm bed)
  
  DIMENSIONS:
  - Width: 6mm (standard binding width)
  - Thickness: 1.5mm
  - Single color (choose your filament)
  
  MEASURING YOUR GUITAR:
  1. Use flexible measuring tape around body edge where binding will go
  2. Add 15% for waste, fitting, and safety: measured × 1.15
  3. Jumbo guitars typically need 1050-1150mm after the 15% margin
  
  INSTALLATION TIPS:
  - Uncoil carefully - warm with heat gun if ABS is brittle
  - Test fit before gluing
  - Sand/scrape edges if needed (built-in ±0.2-0.3mm tolerance)
  - For extra-large guitars (>1200mm needed), increase strip_length_mm
  
  TO CUSTOMIZE:
  - Open in OpenSCAD
  - Use Window → Customizer to adjust length, width via GUI
  - Or edit parameters below directly
*/
// ============================================================================

include <../src/guitar_binding.scad>

// Override parameters for jumbo acoustic binding
strip_length_mm = 1200;  // [500:50:2000] Usable length after uncoiling
strip_width_mm = 6.0;    // [3.0:0.5:10.0] Binding width
strip_height_mm = 1.5;   // [1.0:0.1:3.0] Binding thickness

// Single color binding
enable_purfling = false;
layers = [["Binding", 6.0]];

// Recommended spiral parameters for this size
min_inner_radius_mm = 15;
spiral_pitch_mm = 8.0;
clearance_mm = 2.0;

echo("=== ACOUSTIC JUMBO BINDING ===");
echo("For: Jumbo, Grand Jumbo, large-body acoustics");
echo("Output: 1200mm × 6mm × 1.5mm");
