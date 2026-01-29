// ============================================================================
// ELECTRIC STANDARD BINDING
// ============================================================================
/*
  FOR: Stratocaster, Telecaster, Les Paul, SG, and most electric guitars
  
  TYPICAL PERIMETER: 700-800mm
  THIS PRESET PRODUCES: 800mm usable length (includes 15% safety margin)
  
  PRINT TIME: ~3-4 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~30g ABS (single color)
  BED REQUIREMENT: Fits Bambu X1/P1S (256×256mm bed)
  
  DIMENSIONS:
  - Width: 5mm (typical electric guitar binding width)
  - Thickness: 1.5mm
  - Single color (choose your filament)
  
  MEASURING YOUR GUITAR:
  1. Use flexible measuring tape around body edge where binding will go
  2. Add 15% for waste, fitting, and safety: measured × 1.15
  3. Most electric guitars need 650-850mm after the 15% margin
  
  INSTALLATION TIPS:
  - Uncoil carefully - warm with heat gun if ABS is brittle
  - Test fit before gluing
  - Sand/scrape edges if needed (built-in ±0.2-0.3mm tolerance)
  - Electric binding channels are often shallower - verify fit
  
  TO CUSTOMIZE:
  - Open in OpenSCAD
  - Use Window → Customizer to adjust length, width via GUI
  - Or edit parameters below directly
*/
// ============================================================================

include <../src/guitar_binding.scad>

// Override parameters for electric guitar binding
strip_length_mm = 800;   // [500:50:2000] Usable length after uncoiling
strip_width_mm = 5.0;    // [3.0:0.5:10.0] Binding width
strip_height_mm = 1.5;   // [1.0:0.1:3.0] Binding thickness

// Single color binding
enable_purfling = false;
layers = [["Binding", 5.0]];

// Recommended spiral parameters for this size
min_inner_radius_mm = 15;
spiral_pitch_mm = 7.0;   // Slightly tighter pitch for smaller total length
clearance_mm = 2.0;

echo("=== ELECTRIC STANDARD BINDING ===");
echo("For: Stratocaster, Telecaster, Les Paul, SG");
echo("Output: 800mm × 5mm × 1.5mm");
