// ============================================================================
// ACOUSTIC STANDARD BINDING
// ============================================================================
/*
  FOR: Dreadnought, OM, 000, Grand Auditorium guitars
  
  TYPICAL PERIMETER: 850-950mm
  THIS PRESET PRODUCES: 1000mm usable length (includes 15% safety margin)
  
  PRINT TIME: ~4-6 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~40g ABS (single color)
  BED REQUIREMENT: Fits Bambu X1/P1S (256×256mm bed)
  
  DIMENSIONS:
  - Width: 6mm (standard binding width)
  - Thickness: 1.5mm
  - Single color (choose your filament)
  
  MEASURING YOUR GUITAR:
  1. Use flexible measuring tape around body edge where binding will go
  2. Add 15% for waste, fitting, and safety: measured × 1.15
  3. If you need more than 1000mm total, use acoustic_jumbo preset instead
  
  INSTALLATION TIPS:
  - Uncoil carefully - warm with heat gun if ABS is brittle
  - Test fit before gluing
  - Sand/scrape edges if needed (built-in ±0.2-0.3mm tolerance)
  
  TO CUSTOMIZE:
  - Open in OpenSCAD
  - Use Window → Customizer to adjust length, width via GUI
  - Or edit parameters below directly
*/
// ============================================================================

include <../src/guitar_binding.scad>

// Override parameters for acoustic standard binding
strip_length_mm = 1000;  // [500:50:2000] Usable length after uncoiling
strip_width_mm = 6.0;    // [3.0:0.5:10.0] Binding width
strip_height_mm = 1.5;   // [1.0:0.1:3.0] Binding thickness

// Single color binding
enable_purfling = false;
layers = [["Binding", 6.0]];

// Recommended spiral parameters for this size
min_inner_radius_mm = 15;
spiral_pitch_mm = 8.0;
clearance_mm = 2.0;

echo("=== ACOUSTIC STANDARD BINDING ===");
echo("For: Dreadnought, OM, 000, Grand Auditorium");
echo("Output: 1000mm × 6mm × 1.5mm");
