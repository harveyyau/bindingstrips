// ============================================================================
// MANDOLIN BINDING
// ============================================================================
/*
  FOR: Mandolin, ukulele, and small stringed instruments
  
  TYPICAL PERIMETER: 400-500mm (varies by instrument)
  THIS PRESET PRODUCES: 500mm usable length (includes 15% safety margin)
  
  PRINT TIME: ~2-3 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~20g ABS (single color)
  BED REQUIREMENT: Fits Bambu X1/P1S (256×256mm bed)
  
  DIMENSIONS:
  - Width: 4mm (typical mandolin/ukulele binding width)
  - Thickness: 1.2mm (thinner for smaller instruments)
  - Single color (choose your filament)
  
  MEASURING YOUR INSTRUMENT:
  1. Use flexible measuring tape around body edge where binding will go
  2. Add 15% for waste, fitting, and safety: measured × 1.15
  3. Mandolins typically need 450-550mm after the 15% margin
  4. Ukuleles vary widely: soprano ~350mm, tenor ~450mm, baritone ~500mm
  
  INSTALLATION TIPS:
  - Uncoil carefully - thinner than guitar binding, more delicate
  - Test fit before gluing
  - Sand/scrape edges if needed (built-in ±0.2-0.3mm tolerance)
  - Smaller instruments = tighter curves; this preset uses tighter spiral
  
  TO CUSTOMIZE:
  - Open in OpenSCAD
  - Use Window → Customizer to adjust length, width via GUI
  - Or edit parameters below directly
  - For concert/tenor ukuleles, you may need less length
*/
// ============================================================================

include <../src/guitar_binding.scad>

// Override parameters for mandolin/small instrument binding
strip_length_mm = 500;   // [300:50:2000] Usable length after uncoiling
strip_width_mm = 4.0;    // [3.0:0.5:10.0] Narrow binding width
strip_height_mm = 1.2;   // [1.0:0.1:3.0] Thinner profile

// Single color binding
enable_purfling = false;
layers = [["Binding", 4.0]];

// Recommended spiral parameters for this size (tighter for small instruments)
min_inner_radius_mm = 12;  // Smaller minimum radius
spiral_pitch_mm = 6.0;     // Tighter pitch for shorter strip
clearance_mm = 2.0;

echo("=== MANDOLIN / SMALL INSTRUMENT BINDING ===");
echo("For: Mandolin, ukulele, small stringed instruments");
echo("Output: 500mm × 4mm × 1.2mm");
