// ============================================================================
// ACOUSTIC STANDARD BINDING
// ============================================================================
/*
  FOR: Dreadnought, OM, 000, Grand Auditorium guitars
  
  TYPICAL PERIMETER: 850-950mm  
  THIS PRESET PRODUCES: ~1600mm usable length (bed-filling spiral!)
  
  STRATEGY: Fills entire 240mm bed diameter for MAXIMUM outer bend radius
  → Starts at bed edge (120mm radius), spirals INWARD to center
  → Outer coils have gentle 120mm radius = very easy to unbend and install!
  → Inner coils are tighter but shorter segments = still workable
  → ~1600mm total = enough for most guitars with margin to spare
  
  PRINT TIME: ~2-3 hours (Bambu X1C, 0.2mm layers, 100mm/s)
  FILAMENT NEEDED: ~30-40g ABS (single color)
  BED REQUIREMENT: Fills Bambu X1/P1S (256×256mm bed) completely
  
  DIMENSIONS: 1.5mm WIDE × 6mm TALL (typical guitar binding profile)
  
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

// Override parameters - BED-FILLING INWARD SPIRAL
strip_length_mm = 1600;  // [1000:100:3000] Typical binding length
strip_width_mm = 1.5;    // [1.0:0.5:3.0] THIN dimension (typical: 1.5mm)
strip_height_mm = 6.0;   // [3.0:0.5:10.0] TALL dimension (typical: 6mm)

// Single color binding
enable_purfling = false;
layers = [["Binding", 1.5]];

// BED-FILLING PARAMETERS: Start at edge, spiral inward
max_bed_diameter_mm = 240;  // Full bed diameter (fills 256mm bed)
min_center_radius_mm = 10;  // Spiral to center (10mm minimum)
clearance_mm = 1.0;         // 1mm gap (pitch auto = 1.5+1.0=2.5mm)

echo("=== ACOUSTIC STANDARD BINDING (Inward Spiral) ===");
echo("For: Dreadnought, OM, 000, Grand Auditorium");
echo("Output: ~1600mm × 1.5mm WIDE × 6mm TALL (fills 240mm bed)");
echo("Spiral: 120mm outer radius (GENTLE!) → 10mm inner");
echo("Pitch: 2.5mm (1.5mm binding + 1mm clearance)");
